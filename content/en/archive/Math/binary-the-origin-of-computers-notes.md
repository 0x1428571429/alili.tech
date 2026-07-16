---
title: Math - Binary, the Origin of Computers (Notes)
categories: [Algorithm]
tags: [Daily, Math]
slug: ja86xk20l2
keywords: Artificial Intelligence,Computer Mathematics,Computer Fundamentals,Computer,Front-end Learning AI,Daily Practice
date: 2020-09-01 00:00:00
---

## Origin of Computers

* The origin of computers is binary notation in mathematics.

## What is Binary Notation?

### Daily Decimal

Arabic numerals consist of 10 counting symbols from 0 to 9, and use a positional notation system, advancing one place every 10. Taking 2871 as an example:

![Figure 7](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/294a1909e34794530f44814c77647d1aa7c7c6b487067889af4a1a85b3b857da.png)  

Where ^ represents power or exponentiation. The digits of decimal (thousands, hundreds, tens, etc.) are all in the form of 10^n. It's important to note that any non-zero number to the power of 0 is 1. In this new representation, 10 is called the `base` of decimal notation.

### Binary

We change the base to 2, and we can understand binary representation. For example, 110101.

> Binary digits are in the form of 2^n

![Figure 8](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/d20e54352a5b95b9caafef829f9d00c5b1e4186fa0323d446e62bd624ea6c7e0.png)  

### Other Bases

As long as we change the base, we can use any base to represent our numbers.

### JavaScript Base Conversion

```js

parseInt(num,8); // Octal to decimal
parseInt(num,16); // Hexadecimal to decimal 
parseInt(num).toString(8) // Decimal to octal 
parseInt(num).toString(16) // Decimal to hexadecimal 
parseInt(num,2).toString(8) // Binary to octal 
parseInt(num,2).toString(16) // Binary to hexadecimal
parseInt(num,8).toString(2) // Octal to binary 
parseInt(num,8).toString(16) // Octal to hexadecimal 
parseInt(num,16).toString(2) // Hexadecimal to binary 
parseInt(num,16).toString(8) // Hexadecimal to octal

```

## Why Do Computers Use Binary?

The logic circuits that make up computer systems usually only have two states: switch on and switch off.

## Binary Bit Operations

### Left Shift

Shifting binary 110101 one place to the left means adding a 0 at the end, so 110101 becomes 1101010

![Figure 9](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/0145c13e717d6c03fe7cce4710684fc603d232ee67c68acbf28adcb97607e0ff.png)  

If we convert 1101010 to decimal, it's 106. Have you noticed that 106 is exactly 2 times 53?
> Binary left shift by one place is actually doubling the number.

#### Number Overflow
Number overflow means the number of digits in a binary number exceeds the number specified by the system. Currently, mainstream systems support at least 32-bit integers.

### Right Shift
Shifting binary 110101 one place to the right means removing the last digit, so 110101 becomes 11010

ps. If we convert 11010 to decimal, it's 26, exactly the integer quotient of 53 divided by 2.

> Binary right shift by one place is the operation of dividing the number by 2 and finding the integer quotient.

![Figure 10](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/ea434cec66e0bd73ac5e47353b381784581978f8b12210180d5cbec1fb5cb32f.png)  

### Code Example

```js
console.log(5 << 2);  // Returns 20

console.log(1000 >>> 8);  // Returns 3
```

### Left shift is <<, so why is right shift >>> instead of >>?

* \>> is also a right shift operation
* The highest bit in binary values is the sign bit

![Figure 13](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/7b7b77677b4c83731390422c0b7e4511ce4d8f1914a87afd788f75f88f1c0e09.png)  

> What if the number is -53? Then bit 32 is not 0.

Negative numbers:

![Figure 14](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/02b7f109b46c860ae8355d68d2cfa0cb2ab098aae7320eab932297dd9f5b258f.png)  

### Logical Right Shift >>

Will change the sign bit

![Figure 15](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/bd7aefcf956ccf87fdcf3da3f5703dd21fb6bf9d25edadae55c77d9dc86cf506.png)  

### Arithmetic Right Shift >>

![Figure 16](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/57271a6d6005d04713dccc75528c8e28b6ce766e0ecd8225a97f16bd8111c874.png)  

## Bitwise "OR"
Binary "1" and "0" correspond to "true" and "false" in logic, and we can perform logical operations on bits.

Logical "OR" means that as long as one bit in the participating bits is 1, the final result is 1, which is "true". If we align each bit of binary 110101 and 100011 and perform bitwise "OR" operation, we get 110111.

![Figure 17](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/1ad8b63cfc853ec671c225f05104095a1f152d6e65e5e708fdc5f543b8e194f1.png)  

## Bitwise "AND"

Similarly, we can also perform logical "AND" operations on bits. "AND" means that all participating bits must be 1 for the final result to be 1 (true), otherwise it's 0 (false). If we align each bit of binary 110101 and 100011 and perform bitwise "AND" operation, we get 100001.

![Figure 18](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/a83750a83a4706902b6330abc2b6b72e625dbb55441b30836e476289bd35d4aa.png)  

## Bitwise "XOR"

Logical "XOR" is different from "OR". It has exclusivity, meaning if the participating bits are the same, the final result is 0 (false), otherwise it's 1 (true). So, to get 1, the two participating bits must be different, which is the meaning of "exclusive" here. If we align each bit of binary 110101 and 100011 and perform bitwise "XOR" operation, we can get the result 10110.

![Figure 19](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/66327173c4e0588102c4953bd8023768b9c21ccf3f42848f558e4acaa7edd7eb.png)  

### JavaScript Bitwise AND, OR, XOR Operations

```js
        var a=1;
        var b=0;
 
        // Bitwise AND &: Both operands must be 1 for result to be 1
        a&b // Result is 0
 
        // Bitwise OR: As long as one operand is 1, result is 1
        a|b  // Result is 1
 
        // Bitwise XOR: If two numbers are the same, result is 0; if different, result is 1.
        a^b  // Result is 1
 
        // Simple method: Negate number, then subtract 1
        ~a // Result is -2
```

