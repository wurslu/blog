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
fun divide(a: Int, b: Int): Int {
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

## let - 空安全调用，转换结果

```kotlin
// 最常用：空安全调用
val user: User? = getUser()
user?.let {
    println("用户名: ${it.name}")
    println("年龄: ${it.age}")
} // 只有user不为null才执行

// 转换结果
val result = "hello".let {
    it.uppercase() + "!!!"
} // result = "HELLO!!!"
```

## apply - 链式调用时有用

```kotlin
// 没有apply的写法
val textView = TextView(this)
textView.text = "标题"
textView.textSize = 18f
textView.setTextColor(Color.BLACK)
addView(textView) // 需要保存变量

// 用apply - 可以直接链式调用
addView(TextView(this).apply {
    text = "标题"
    textSize = 18f
    setTextColor(Color.BLACK)
}) // 不需要临时变量
```

## with/run - 用处不大，装逼用的

```kotlin
// with 的所谓"优势"
with(sharedPreferences.edit()) {
    putString("name", "张三")
    putInt("age", 25)
    apply()
}

// 不用 with 直接写
val editor = sharedPreferences.edit()
editor.putString("name", "张三")
editor.putInt("age", 25)
editor.apply()
```

## observable 简化版

```kotlin
fun <T> observable(initialValue: T, onChange: (KProperty<*>, T, T) -> Unit) {
    return object {
        private var value = initialValue

        operator fun getValue(thisRef: Any?, property: KProperty<*>): T {
            return value  // get时直接返回
        }

        operator fun setValue(thisRef: Any?, property: KProperty<*>, newValue: T) {
            val oldValue = value
            value = newValue  // 先设置新值
            onChange(property, oldValue, newValue)  // 然后调用你的回调
        }
    }
}
```

## by

本质是把属性的 get/set 操作委托给另一个对象

```kotlin
fun main() {
    var userName by observable("default"){ _, oldValue, newValue ->
        println("oldValue:$oldValue change to $newValue")
    }
    println(userName) // default
    userName = "alice" // oldValue:default change to alice
    println(userName) // alice
}
```

## by vetoable - 可以拒绝的属性修改

修改属性前先检查，不合法就拒绝

```kotlin
fun main() {
    var score by vetoable(10) { _, _, newValue ->
        newValue >= 0 // 返回true表示允许修改，false表示拒绝
    }
    println(score) // 10
    score = -10
    println(score) // 10
}
```

### Android 中的应用举例

```kotlin
class UserProfile {
    // 用户名改变时自动更新UI
    var userName: String by observable("") { _, _, newName ->
        binding.nameTextView.text = newName
        saveUserName(newName) // 自动保存
    }

    // 限制输入范围
    var volume: Int by vetoable(50) { _, _, newVolume ->
        newVolume in 0..100 // 音量只能0-100
    }
}
```
