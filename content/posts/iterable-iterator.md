+++
date = '2025-07-05T23:51:22+08:00'
draft = false
title = 'Iterable Iterator'
tags = ['Kotlin','Iterable 接口','Iterator 模式','自定义迭代器']
categories = ['Kotlin','Basic']
+++

## 简单场景描述

我们拥有一个数据类`MyDate` ，一个获取下一天的方法`followingDate`以及重写`rangeTo`操作符。

```kotlin
data class MyDate(val year: Int, val month: Int, val dayOfMonth: Int) : Comparable<MyDate> {
    override fun compareTo(other: MyDate): Int = when {
        year != other.year -> year - other.year
        month != other.month -> month - other.month
        else -> dayOfMonth - other.dayOfMonth
    }

    fun followingDate(): MyDate {
        val localDate = LocalDate.of(year, month, dayOfMonth)
        val nextDay = localDate.plusDays(1)
        return MyDate(nextDay.year, nextDay.monthValue, nextDay.dayOfMonth)
    }

    operator fun rangeTo(other: MyDate): DateRange = DateRange(this, other)
}
```

我们想要使用`for loop`来遍历`MyDate`区间中的每一天。

```kotlin
fun iterateOverDateRange(firstDate: MyDate, secondDate: MyDate, handler: (MyDate) -> Unit) {
    for (date in firstDate..secondDate) {
        handler(date)
    }
}
```

那么我们的目标是：Make the class `DateRange` implement [`Iterable<MyDate>`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-iterable/) ，**正确答案**如下。

```kotlin
class DateRange(val start: MyDate, val end: MyDate) : Iterable<MyDate> {
    override fun iterator(): Iterator<MyDate> {
        return object : Iterator<MyDate> {
            var current: MyDate = start

            override fun hasNext(): Boolean = current <= end

            override fun next(): MyDate {
                if (!hasNext()) throw NoSuchElementException()
                val result = current
                current = current.followingDate()
                return result
            }
        }
    }
}
```

## 开始

### 首先，为什么需要实现 Iterable？

你想用 for 循环遍历日期范围：

```kotlin

kotlin
for (date in dateRange) {
// 处理每个日期
}

```

但是 Kotlin 怎么知道如何遍历你的 `DateRange` 呢？它需要知道：

- 从哪里开始？
- 什么时候结束？
- 怎么获取下一个元素？

这就是 `Iterable` 接口的作用！

### Iterable 接口要求什么？

```kotlin
interface Iterable<T> {
    fun iterator(): Iterator<T>
}
```

它只要求你提供一个 `iterator()` 方法，返回一个 `Iterator` 对象。

### Iterator 是什么？

`Iterator` 就像一个"指针"，它知道：

- 当前位置在哪里
- 是否还有下一个元素
- 如何获取下一个元素

```kotlin
interface Iterator<T> {
    fun hasNext(): Boolean  // 还有下一个吗？
    fun next(): T          // 给我下一个！
}
```

### 为什么要 return object？

因为`Iterable`接口要求重写`iterator()`方法病缺返回一个对象`Iterator<T>`。
