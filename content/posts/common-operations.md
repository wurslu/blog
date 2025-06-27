+++
date = '2025-06-27T20:25:44+08:00'
draft = false
title = 'Common Operations'
+++

只需要知道有这些操作

## shuffle() vs shuffled()

```kotlin
fun main() {
    val list: MutableList<Int> = mutableListOf(1, 2, 3, 4, 5)
    val shuffledList = list.shuffled() // shuffled 返回打乱后的集合
    println(list)
    println(shuffledList)

    list.shuffle()
    println(list)
}
```

## map()

```kotlin
fun main() {
    val numbers = listOf(1, 2, 3)
    val doubled = numbers.map { it * 2 } // [2, 4, 6]
    val strings = numbers.map { "数字$it" } // ["数字1", "数字2", "数字3"]
}
```

## toSet()

```kotlin
fun main() {
    val list = listOf(1, 2, 3, 2, 1)
    val set = list.toSet()
    println(set) // [1, 2, 3]
}
```

## sortedDescending()

```kotlin
fun main() {
    val list = listOf(1, 2, 3, 2, 1)
    val sorted = list.sortedDescending() //降序排列
    println(sorted) // [3, 2, 2, 1, 1]
}
```

## filter()

```kotlin
fun main() {
    val list = listOf(2, 4, 3, 6, 1)
    val filter = list.filter { it % 2 == 0 }
    println(filter) // [2, 4, 6]
}
```

## groupingBy { }.eachCount()

```kotlin
fun main() {
    val words = listOf("apple", "banana", "apple", "cherry", "banana")
    val counts = words.groupingBy { it }.eachCount()
    println(counts)  // {apple=2, banana=2, cherry=1}
}
```

## entries()

```kotlin
fun main() {
    val map = mapOf(1 to 2, 3 to 4)
    map.entries.forEach { (key, value) ->
        println("$key, $value")
    }
}
```

## addAll()

```kotlin
fun main() {
    val list1 = mutableListOf(1, 23, 45, 6)
    val list2 = listOf(666666, 888888)
    list1.addAll(list2)
    println(list1) // [1, 23, 45, 6, 666666, 888888]
}
```

## buildList { }

```kotlin
fun main() {
    val list = buildList {
        add(1)
        add(2)
        addAll(listOf(3, 4))
    }
    println(list) // [1, 2, 3, 4]
}
```

## require() - 检查参数

```kotlin
fun devide(a: Int, b: Int): Int {
    require(b != 0) { "除数不能为 0" }
    return a / b
}
```

## check() - 检查当前状态

```kotlin
class BankAccount {
    private var balance: Int = 0

    fun withDraw(amount: Int) {
        check(this.balance >= amount) { "余额不足" }
        this.balance -= amount
    }
}
```

## Elvis 运算符

```kotlin
// 本质就是 val displayName = if (name != null) name else "默认值"
val displayName = name ?: "默认值
```

## takeIf - 条件取值

```kotlin
val validAge = age.takeIf { it > 0 } // 大于0才返回，否则null
val invalidAge = age.takeUnless { it > 100 } // 小于等于100才返回
```
