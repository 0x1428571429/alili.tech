---
title: Math - Computer Origin Binary (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: ja86xk20l2
keywords: Artificial Intelligence,Computer Math,Computer Basics,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-01 00:00:00
---

## Computer Origin

* Computer's origin is binary counting method in mathematics



## What is Binary Counting Method?

### Daily Decimal

Arabic numerals consist of 10 counting symbols from 0 to 9, and adopt carry system, every 10 carries one place, take 2871 as example


![Figure 7](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/294a1909e34794530f44814c77647d1aa7c7c6b487067889af4a1a85b3b857da.png)  

Where ^ represents power or exponentiation operation. Decimal digit places (thousands, hundreds, tens, etc.) are all in form of 10^n. Need special attention, any non-zero number's 0th power is 1. In this new representation, 10 is called decimal counting method's `base`.


### Binary

We change base to 2, can understand binary representation. For example 110101.

> Binary digit places are in form of 2^n

![Figure 8](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d20e54352a5b95e9caafef829f9d00c5b1e4186fa0323d446e62bd624ea6c7e0.png)  

### Other Bases

We just need to change base, can use any base to represent our numbers.

### JavaScript Base Conversion

```js

parseInt(num,8); //Octal to decimal
parseInt(num,16); //Hexadecimal to decimal 
parseInt(num).toString(8) //Decimal to octal 
parseInt(num).toString(16) //Decimal to hexadecimal 
parseInt(num,2).toString(8) //Binary to octal 
parseInt(num,2).toString(16) //Binary to hexadecimal
parseInt(num,8).toString(2) //Octal to binary 
parseInt(num,8).toString(16) //Octal to hexadecimal 
parseInt(num,16).toString(2) //Hexadecimal to binary 
parseInt(num,16).toString(8) //Hexadecimal to octal

```


## Why Do Computers Use Binary?
Logic circuits composing computer systems usually only have two states, i.e., switch connection and disconnection. 


## Binary Bit Operations

### Left Shift

Binary 110101 shifted left one bit, is adding a 0 at the end, so 110101 becomes 1101010

![Figure 9](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/0145c13e717d6c03fe7cce4710684fc603d232ee67c68acbf28adcb97607e0ff.png)  


If convert 1101010 to decimal, is 106, have you noticed, 106 is exactly 2 times 53
> Binary left shift one bit, is actually doubling the number.

#### Number Overflow
Number overflow means binary number's digits exceed system specified digits. Currently mainstream systems support at least 32-bit integer numbers




### Right Shift
Binary 110101 shifted right one bit, is removing the last bit, so 110101 becomes 11010

ps. If we convert 11010 to decimal, is 26, exactly 53 divided by 2's integer quotient

> Binary right shift one bit, is operation of dividing number by 2 and finding integer quotient


![Figure 10](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/ea434cec66e0bd73ac5e47353b381784581978f8b12210180d5cbec1fb5cb32f.png)  

### Code Example

```js
console.log(5 << 2);  //Returns 20

console.log(1000 >>> 8);  //Returns 3
```


### Left shift is <<, why is right shift >>> instead of >>?

*  >> is also right shift operation
*  Highest bit in binary value is sign bit


![Figure 13](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/7b7b77677b4c83731390422c0b7e4511ce4d8f1914a87afd788f75f88f1c0e09.png)  


> What if number is -53? Then 32nd bit is not 0

Negative numbers:

![Figure 14](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/02b7f109b46c860ae8355d68d2cfa0cb2ab098aae7320eab932297dd9f5b258f.png)  


### Logical Right Shift >>

Will change sign bit


![Figure 15](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/bd7aefcf956ccf87fdcf3da3f5703dd21fb6bf9d25edadae55c77d9dc86cf506.png)  


### Arithmetic Right Shift >>

![Figure 16](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/57271a6d6005d04713dccc75528c8e28b6ce766e0ecd8225a97f16bd8111c874.png)  



## Bit "OR"
Binary "1" and "0" respectively correspond to logic "true" and "false", can perform logic operations on bits


Logic "OR" means, among participating bits, as long as one bit is 1, final result is 1, i.e., "true". If we align each bit of binary 110101 and 100011, perform bitwise "OR" operation, will get 110111.


![Figure 17](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/1ad8b63cfc853ec671c225f05104095a1f152d6e65e5e708fdc5f543b8e194f1.png)  


## Bit "AND"

Similarly, we can also perform logic "AND" operations on bits. "AND" means, among participating bits, must all be 1, then final result is 1 (true), otherwise is 0 (false). If we align each bit of binary 110101 and 100011, perform bitwise "AND" operation, will get 100001.


![Figure 18](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/a83750a83a4706902b6330abc2b6b72e625dbb55441b30836e476289bd35d4aa.png)  


## Bit "XOR"

Logic "XOR" differs from "OR", it has exclusivity, meaning if participating bits are the same, final result is 0 (false), otherwise is 1 (true). So, to get 1, two participating bits must be different, this is "exclusive" meaning here. We align each bit of binary 110101 and 100011, perform bitwise "XOR" operation, can get result 10110.

![Figure 19](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/66327173c4e0588102c4953bd8023768b9c21ccf3f42848f558e4acaa7edd7eb.png)  


### javascript Bitwise AND, Bitwise OR, Bitwise XOR Operations

```js
        var a=1;
        var b=0;
 
        //Bitwise AND &: Both operands are 1, result is 1
        a&b //Result is 0
 
        //Bitwise OR: As long as one operand is 1, result is 1
        a|b  //Result is 1
 
        //Bitwise XOR: Two numbers same, result is 0; two numbers different, result is 1.
        a^b  //Result is 1

        //Simple method: Number negation, subtract 1
        ~a //Result is -2
```

