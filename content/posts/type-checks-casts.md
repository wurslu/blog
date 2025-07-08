+++
date = '2025-07-06T12:00:18+08:00'
draft = false
title = 'Type Checks Casts'
tags = ['Kotlin','Smart Casts','Type Checks']
categories = ['Kotlin','Basic']
+++

## is and !is operators

is 用于执行运行时确定对象是否符合给定类型。

```kotlin
if (obj is String) {
    print(obj.length)
}

if (obj !is String) { // Same as !(obj is String)
    print("Not a String")
} else {
    print(obj.length)
}
```

## smart casts

### 核心原理

编译器自动跟踪类型检查结果，无需手动强制转换，直接使用目标类型的属性和方法。

```kotlin
fun demo(x: Any) {
    if (x is String) {
        print(x.length)  // 编译器自动将 x 转换为 String 类型
    }
}
```

### **支持的控制流**

- **`if`  条件**：通过  `is`  或  `!is`  检查后，块内自动转换。
- **`when`  表达式**：根据不同类型分支自动转换。

```kotlin
when (x) {
    is Int -> print(x + 1)
    is String -> print(x.length + 1)
    is IntArray -> print(x.sum())
}
```

• **`while`  循环**：只要类型检查条件成立，循环内保持转换状态。

### 特殊场景

**逻辑操作符（`&&`/`||`）**

- 左侧为类型检查时，右侧自动转换。

```kotlin
if (x is String && x.length > 0) {
    print(x.length)  // x 自动转换为 String
}
if (x !is String || x.length == 0) return  // x 在右侧自动转换为 String
```

### **变量提取**

将类型检查结果存入布尔变量，仍可触发智能转换。

```kotlin
fun petAnimal(animal: Any) {
    val isCat = animal is Cat
    if (isCat) {
        animal.purr()  // 编译器通过 isCat 推断 animal 是 Cat 类型
    }
}
```

## **类型转换操作符**

### **不安全转换（`as`）**

- **语法**：`obj as Type`，若转换失败抛出  `ClassCastException`。
- **注意**：若目标类型不可为空（如  `String`），源对象为  `null`  时也会抛异常。

```kotlin
val x: String = y as String  // 若 y 为 null 或非 String 类型，抛出异常
```

[](data:image/png;base64,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)

- **安全用法**：搭配可空类型使用。

```kotlin
val x: String? = y as String?  // 若 y 为 null，x 为 null；若 y 非 String，抛异常
```

### **安全转换（`as?`）**

- **语法**：`obj as? Type`，转换失败返回  `null`，不抛异常。
- **应用场景**：处理可能转换失败的情况，避免程序崩溃。

```kotlin
val x: String? = y as? String  // 若 y 非 String 或为 null，x 为 null
```

## **其他重要场景**

- **内联函数（Inline Functions）中的智能转换**

内联函数会将 lambda 代码直接嵌入调用处，编译器可保证变量引用不会 “泄漏”，因此可对 lambda 中捕获的变量进行智能转换。

```kotlin
inline fun <T> processIfNotNull(obj: T?, action: (T) -> Unit) {
    if (obj != null) {
        action(obj)  // 智能转换 obj 为非空类型
    }
}

fun runProcessor() {
    val processor: Processor? = getProcessor()
    processIfNotNull(processor) { proc ->
        proc.process()  // 直接调用，无需安全操作符
    }
}
```

- **异处理中的智能转换**

`try`  块中若变量被赋值为非空，编译器会记住其类型；若变量在  `try`  块中被设为  `null`，则取消智能转换。

`catch`  块中变量恢复为可空类型，需使用安全操作符（`?.`）。

```kotlin
fun testString() {
    var stringInput: String? = ""  // 智能转换为 String
    try {
        println(stringInput.length)  // 非空，直接访问
        stringInput = null  // 取消智能转换，变为 String?
        // ...
    } catch (e: Exception) {
        println(stringInput?.length)  // 需用安全操作符
    }
}
```
