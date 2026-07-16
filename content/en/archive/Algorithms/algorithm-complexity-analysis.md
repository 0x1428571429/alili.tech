---
title: Algorithm Complexity Analysis
slug: algorithm-complexity-analysis
date: 2017-12-19 22:17:36
keywords: [Algorithms,Data Structures]
categories: [Algorithm]
tags: [Algorithms]
---

Everything is to count the efficiency of code execution


## Post-Statistical Method

Through statistics and monitoring, we can get the execution time and memory usage of the algorithm


## Big O Complexity Notation

As data scale grows, algorithm execution time and space usage grow proportionally according to polynomials

### Time Complexity Ranking (from best to worst)

![Figure 1](https://incomparable9527.coding.net/p/imageBed/d/imageBed/git/raw/master/35125f99fc7c79d019449ecdf8ef04434feaef35ccc580fd22326dffe1e58ca6.png)  



O(1) (constant order) < O(logn) (logarithmic order) < O(n) (linear order) < O(nlogn) (linear logarithmic order) < O(n^2) (quadratic order) < O(n^3) (cubic order) < O(2^n) (exponential order) < O(n!) (factorial order)

### Constant Order O(1)

```java
 int i = 8;
 int j = 6;
 int sum = i + j;
```


### Linear Order O(n)

```java
for(i=1; i<=n; ++i)
{
   j = i;
   j++;
}
```

### Logarithmic Order O(logn)

```java
 i=1;
 while (i <= n)  {
   i = i * 2;
 }
```

### Linear Logarithmic Order O(nlogN)

```java
for(m=1; m<n; m++)
{
    i = 1;
    while(i<n)
    {
        i = i * 2;
    }
}
```


### O(m+n), O(m*n)

```java

int cal(int m, int n) {
  int sum_1 = 0;
  int i = 1;
  for (; i < m; ++i) {
    sum_1 = sum_1 + i;
  }

  int sum_2 = 0;
  int j = 1;
  for (; j < n; ++j) {
    sum_2 = sum_2 + j;
  }

  return sum_1 + sum_2;
}

```

### Quadratic Order O(n²)
```java
for(x=1; i<=n; x++)
{
   for(i=1; i<=n; i++)
    {
       j = i;
       j++;
    }
}
```




## Best and Worst Case Complexity

* Best case time complexity is the time complexity of executing this code in the most ideal situation

* Worst case time complexity is the time complexity of executing this code in the worst situation.


## Space Complexity

Asymptotic space complexity represents the growth relationship between algorithm storage space and data scale

### Space Complexity O(1)

```java
int i = 1;
int j = 2;
++i;
j++;
int m = i + j;
```

### Space Complexity O(n)

```java
int[] m = new int[n]
for(i=1; i<=n; ++i)
{
   j = i;
   j++;
}
```
