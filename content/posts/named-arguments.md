+++
date = '2025-07-02T13:46:01+08:00'
draft = false
title = 'Named Arguments'
tags = ['Kotlin','named arguments','Kotlin Koans']
categories = ['Kotlin','Basic']
+++

Make the function `joinOptions()` return the list in a JSON format (for example, `[a, b, c]`) by specifying only two arguments.

[Default and named](https://kotlinlang.org/docs/functions.html#default-arguments) arguments help to minimize the number of overloads and improve the readability of the function invocation. The library function [`joinToString`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/join-to-string.html) is declared with default values for parameters:

```kotlin
**fun** joinToString(

    separator: String = ", ",

    prefix: String = "",

    postfix: String = "",

    /* ... */

): String
```

It can be called on a collection of Strings.

```kotlin
fun joinOptions(options: Collection<String>) =
        options.joinToString(TODO())
```

你将会在[这里](https://play.kotlinlang.org/koans/Introduction/Named%20arguments/Task.kt)看到答案或者继续进行其他练习。
