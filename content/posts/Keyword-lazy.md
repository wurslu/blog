+++
date = '2025-07-02T13:00:53+08:00'
draft = false
title = 'lazy'
tags = ['Kotlin','lazy']
categories = ['Kotlin','Basic']
+++

## Kotlin 中的 `lazy`

在 Kotlin 中，`lazy` 是一个用于**延迟初始化**属性或值的函数。这意味着一个属性的值直到第一次被访问时才会被计算。这在以下场景中非常有用：

- **性能优化：** 如果一个对象的创建成本很高，但它不总是立即需要，那么 `lazy` 可以避免不必要的计算，从而提高应用程序的启动速度或响应能力。
- **资源管理：** 当初始化某个对象会占用大量资源（例如，数据库连接、文件句柄等）时，使用 `lazy` 可以确保这些资源只在真正需要时才被分配。
- **处理循环依赖：** 在某些复杂对象模型中，可能存在对象之间的循环依赖。`lazy` 有时可以帮助解决这种问题，因为它允许你推迟一个对象的初始化，直到另一个对象已经完全构建。

### `lazy` 的基本用法

`lazy` 函数接受一个 lambda 表达式作为参数，这个 lambda 表达式定义了如何计算被延迟初始化的值。它返回一个 `Lazy<T>` 实例，你可以通过调用其 `value` 属性来获取实际的值。

```kotlin
val myLazyValue: String by lazy {
    println("正在初始化 myLazyValue...")
    "这是一个延迟初始化的字符串"
}

fun main() {
    println("程序开始运行")
    println(myLazyValue) // 第一次访问，会触发初始化
    println(myLazyValue) // 第二次访问，直接使用已初始化的值
}
```

输出：

```kotlin
程序开始运行
正在初始化 myLazyValue...
这是一个延迟初始化的字符串
这是一个延迟初始化的字符串
```

从上面的输出可以看出，"正在初始化 myLazyValue..." 这句话只打印了一次，证明了 `myLazyValue` 只在第一次访问时才被初始化。
