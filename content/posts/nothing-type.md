+++
date = '2025-07-02T19:15:41+08:00'
draft = false
title = 'Nothing type'
tags = ['Kotlin','Nothing type']
categories = ['Kotlin','Basic']
+++

[Nothing type](https://kotlinlang.org/docs/exceptions.html#the-nothing-type) can be used as a return type for a function that always throws an exception. When you call such a function, the compiler uses the information that the execution doesn't continue beyond the function.

```kotlin
import kotlin.IllegalArgumentException

fun failWithWrongAge(age: Int?) {
    throw IllegalArgumentException("Wrong age: $age")
}

fun checkAge(age: Int?) {
    if (age == null || age !in 0..150) failWithWrongAge(age)
    println("Congrats! Next year you'll be ${age + 1}.")
}

fun main() {
    checkAge(10)
}
```

如果这里`failWithWrongAge` 方法没有标明返回值类型为`Nothing` ，那么 the `checkAge` function doesn't compile because the compiler assumes the `age` can be `null`.你应该 Specify `Nothing` return type for the `failWithWrongAge` function.
