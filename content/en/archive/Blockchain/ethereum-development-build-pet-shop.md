---
title: Ethereum Development - Build Pet Shop
categories: [Blockchain]
tags: [Blockchain]
slug: b75b18ec
keywords: Blockchain,Ethereum,remix-ide,Solidity,truffle,Pet Shop
date: 2018-04-21 19:33:33
---

Truffle's pet shop is a very good example to understand Ethereum development.
Following official provided demo and tutorial, can completely experience entire development process.

## Ganache
For environment needs, and quickly set up a private chain environment locally.
truffle launched a visual private chain client:
[Ganache Download Address](http://truffleframework.com/ganache/)
After downloading and running, you'll see an interface like this:
![](https://static.alili.tech/images/Jietu20180421-213717.jpg)

## Initialize Your Project
First we create a new directory, and initialize the project

```bash
$ mkdir pet-shop
$ cd pet-shop
$ truffle unbox pet-shop
```

## Project Directory Structure
Here only lists important directories and files
```
├── bs-config.json
├── contracts //Contract directory
│   └── Migrations.sol //Contract file
├── migrations // Deployment scripts
│   └── 1_initial_migration.js
├── package-lock.json
├── package.json
├── src // Front-end code directory
├── test // Test code directory
└── truffle.js // truffle configuration file
```

## Write Smart Contract
In contracts/ directory, create an Adoption.sol file
File content:

```javascript
pragma solidity ^0.4.17;

contract Adoption {

  address[16] public adopters;  // Declare an address variable to save adopter addresses

    // Adopt pet
  function adopt(uint petId) public returns (uint) {
    require(petId >= 0 && petId <= 15);  // Ensure pet id is correct, between 0 and 15,
                                         // If doesn't meet condition will rollback    
    //msg.sender is address of person calling this function
    adopters[petId] = msg.sender;        // Save caller address 
    return petId;
  }

  // Return adopters
  function getAdopters() public view returns (address[16]) {
    return adopters;
  }

}
```

## Compile Your Smart Contract

```bash
$ truffle compile

//Output
Compiling ./contracts/Adoption.sol...
Writing artifacts to ./build/contracts
```
This way you'll find your project has a build folder,
Inside stores json files of smart contract just written compiled

## Deploy Your Smart Contract
Your smart contract is written, you can temporarily understand as your backend code is written. Need to deploy for front-end to call.

In your `migrations/` directory create a deployment script: `2_deploy_contracts.js`
```javascript
var Adoption = artifacts.require("Adoption");

module.exports = function(deployer) {
  deployer.deploy(Adoption);
};
```

Open Ganache just downloaded, Ganache will start a private chain.
Our smart contract will be deployed on this private chain.

Confirm project root directory's truffle.js
```javascript
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545, //Ensure port address, whether consistent with private chain address, if not consistent please keep consistent
      network_id: "*" // Match any network id
    }
  }
};

```

Execute following command, deploy contract:
```bash
truffle  migrate

# Output
Using network 'develop'.

Running migration: 1_initial_migration.js
  Deploying Migrations...
  ... 0x3076b7dac65afc44ec51508bf6f2b6894f833f0f9560ecad2d6d41ed98a4679f
  Migrations: 0x8cdaf0cd259887258bc13a92c0a6da92698644c0
Saving successful migration to network...
  ... 0xd7bc86d31bee32fa3988f1c1eabce403a1b5d570340a3a9cdba53a472ee8c956
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying Adoption...
  ... 0x2c6ab4471c225b5473f2079ee42ca1356007e51d5bb57eb80bfeb406acc35cd4
  Adoption: 0x345ca3e014aaf5dca488057592ee47305d9b3e10
Saving successful migration to network...
  ... 0xf36163615f41ef7ed8f4a8f192149a0bf633fe1a2398ce001bf44c43dc7bdda0
Saving artifacts...
```

Reopen Ganache, you'll find blockchain state has changed, added 4 blocks.
OK, deployment complete
![](https://learnblockchain.cn/images/ganache-migrated.png)

## Front-end and Smart Contract Interaction
Alright, smart contract we've deployed. Next we'll start our javascript part
Open `src/js/app.js`

## Initialize web3
web3 is a library for front-end to communicate with Ethereum, all operations calling smart contracts, we implement based on web3.

We find initWeb3 method in app.js, add following code:
```javascript
initWeb3: function() {
  // Check if there's global web3 object, generally if installed MetaMask wallet will have global web3 object
  if (typeof web3 !== 'undefined') {
    // If exists, use directly
    App.web3Provider = web3.currentProvider;
  } else {
    // If no global web3 object, directly initialize one locally
    App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
  }
  web3 = new Web3(App.web3Provider);

  return App.initContract();
}
```

## Instantiate Smart Contract
Find initContract method part, add following code:
```javascript
initContract: function() {
  //Load our previously written smart contract
  $.getJSON('Adoption.json', function(data) {
    // Use Adoption.json data to create an interactive TruffleContract contract instance.
    var AdoptionArtifact = data;
    //TruffleContract is this project's global method, uses truffle-contract library
    //If in other projects, you can directly npm i truffle-contract --save to install this library
    //Used to instantiate contract
    App.contracts.Adoption = TruffleContract(AdoptionArtifact);

    // Set the provider for our contract
    App.contracts.Adoption.setProvider(App.web3Provider);

    // Use our contract to retrieve and mark the adopted pets
    return App.markAdopted();
  });
  return App.bindEvents();
}
```

## Adoption Part


handleAdopt method part, add following code:
```javascript
handleAdopt: function(event) {
  event.preventDefault();
  //Get pet id from dom
  var petId = parseInt($(event.target).data('id'));

  var adoptionInstance;

  // Get user account
  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }
    //Get user, if installed wallet will only return array of length 1, if no wallet installed, will return all user addresses
    var account = accounts[0];
    //Call smart contract
    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;

      // Send transaction to adopt pet
      return adoptionInstance.adopt(petId, {from: account});
    }).then(function(result) {
      return App.markAdopted();
    }).catch(function(err) {
      console.log(err.message);
    });
  });
}
```

Find markAdopted method, add following code:
```javascript
markAdopted: function(adopters, account) {
  var adoptionInstance;
  //Call contract method
  App.contracts.Adoption.deployed().then(function(instance) {
    adoptionInstance = instance;

    // Call contract's getAdopters(), using call to read information doesn't consume gas
    return adoptionInstance.getAdopters.call();
  }).then(function(adopters) {
    for (i = 0; i < adopters.length; i++) {
      if (adopters[i] !== '0x0000000000000000000000000000000000000000') {
        $('.panel-pet').eq(i).find('button').text('Success').attr('disabled', true);
      }
    }
  }).catch(function(err) {
    console.log(err.message);
  });
}
```


## Start Service
Alright, all code we've filled in, start our project, start adopting pets you like
```bash
$ npm run dev
```

