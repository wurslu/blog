+++
date = '2025-06-29T15:26:20+08:00'
draft = false
title = 'Function Signature'
tags = ['Kotlin','函数签名']
categories = ['Kotlin','Basic']
+++

## 看一个函数签名

```kotlin
inline fun <reified T : Comparable<T>, R : Any> Collection<T>.complexTransform(
    crossinline predicate: (T) -> Boolean = { true },
    noinline keySelector: (T) -> String,
    transform: T.() -> R?
): Map<String, List<R>> where T : CharSequence
```

这个函数的意思是：

1. 给 Collection 添加一个扩展方法
2. T 必须能比较大小，且是字符序列，且支持泛型具体化
3. R 不能是 null 类型
4. 接收三个函数参数：过滤条件、键选择器、转换器
5. 返回按键分组的转换结果

## 记录

### 返回类型（最简单的部分）

```kotlin
: Map<String, List<R>>
```

返回一个 Map，键是`String`，值是`List<R>`

### 函数名和接收者

```kotlin
Collection<T>.complexTransform
```

`Collection<T>.` 表示这是扩展函数，意思是给 `Collection` 类型"加"了一个方法，可以这样调用：`myList.complexTransform(...)`

### 泛型参数

```kotlin
<reified T : Comparable<T>, R : Any>
```

- `reified T` - 泛型具体化，可以在运行时知道 T 的具体类型
- `: Comparable<T>` - T 必须能够比较大小
- `where T : CharSequence` - 额外约束，T 还必须是字符序列
- `R : Any` - R 不能是 null 类型

### 参数列表

参数 1：

```kotlin
crossinline predicate: (T) -> Boolean = { true }
```

- `crossinline` - 内联限制修饰符
- `predicate` - 参数名
- `(T) -> Boolean` - 函数类型，接收 T 返回 Boolean
- `= { true }` - 默认值，默认总是返回 true

参数 2：

```kotlin
noinline keySelector: (T) -> String
```

- `noinline` - 不内联修饰符
- 函数类型：接收 T 返回 String
- 没有默认值，必须传入

参数 3：

```kotlin
transform: T.() -> R?
```

- `T.()` - 扩展函数类型，T 的方法
- `-> R?` - 返回可空的 R 类型

### 函数修饰符

```kotlin
inline fun
```

`inline` - 内联函数，编译时展开，提高性能
