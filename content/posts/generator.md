+++
date = '2025-07-06T10:12:40+08:00'
draft = false
title = 'Generator'
tags = ['Kotlin','Generator']
categories = ['Kotlin','Basic']
+++

生成器是一种特殊的迭代器，使用  **延迟计算**  生成元素，无需预先准备所有数据。在`Kotlin`中通过  `iterator()`  函数和  `yield`  关键字实现（协程的简化版）。那么我们在[迭代器](https://blog.urlu.cool/posts/iterable-iterator/)所实现的方法，也可以用生成器来替代。

```kotlin
class DateRange(val start: MyDate, val end: MyDate) : Iterable<MyDate> {
    override fun iterator(): Iterator<MyDate> = iterator {
        var current = start
        while (current <= end) {
            yield(current)
            current = current.followingDate()
        }
    }
}
```
