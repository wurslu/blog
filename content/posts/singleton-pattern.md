+++
date = '2025-07-01T22:52:48+08:00'
draft = false
title = 'Singleton Pattern'
+++

单例模式是一种创建型设计模式，它的核心思想是确保一个类在整个应用程序运行期间只能创建一个实例，并提供全局访问这个实例的方法。

想象一个公司只有一台打印机，所有员工都需要使用它。你不会为每个员工都买一台打印机，而是让大家共享这一台。单例模式就是这个道理 - 对于某些资源，我们只需要一个实例就够了。

## 1. Object 关键字实现（最推荐）

```kotlin
// 1. Object关键字实现单例
object DatabaseManager {
    private var connectionCount = 0

    init {
        println("DatabaseManager 初始化")
        connect()
    }

    private fun connect() {
        println("连接到数据库")
        connectionCount++
    }

    fun executeQuery(sql: String): String {
        return "执行查询: $sql, 连接数: $connectionCount"
    }

    fun getConnectionCount(): Int = connectionCount
}

// 使用示例
fun main() {
    println("=== Object关键字单例示例 ===")

    // 直接使用，无需获取实例
    println(DatabaseManager.executeQuery("SELECT * FROM users"))
    println(DatabaseManager.executeQuery("SELECT * FROM orders"))

    println("连接数: ${DatabaseManager.getConnectionCount()}")

    // 验证是同一个实例
    val ref1 = DatabaseManager
    val ref2 = DatabaseManager
    println("是否为同一个实例: ${ref1 === ref2}")
}
```

### Object 关键字的特点

- 自动线程安全：Kotlin 编译器保证 object 的初始化是线程安全的，使用双重检查锁定机制。
- 懒加载：object 在第一次被访问时才会初始化，不是在程序启动时。
- 简洁性：代码最简洁，无需手动管理实例。
- 内存效率：编译后生成的字节码与手写的单例模式相当。
- 适用场景：大多数单例需求都可以用 object 解决，特别是工具类、管理器类等。

### Object 关键字不够用的地方

- 需要构造参数
- 需要依赖注入
- 需要生命周期管理
- 需要复杂继承关系

## 什么条件需要单例模式？

1. 资源管理类：数据库连接池、文件系统访问、网络连接管理器等需要统一管理系统资源的场景。
2. 配置管理：应用程序配置、用户偏好设置等需要全局访问且保持一致性的数据。
3. 缓存系统：内存缓存、图片缓存等需要全局共享且避免重复创建的组件。
4. 日志记录器：应用日志管理，需要统一的日志记录入口。
5. 硬件接口控制：打印机驱动、传感器控制等只能有一个实例操作的硬件接口。

## 什么条件能用单例模式？

1. 无状态或状态不可变：单例对象最好是无状态的，或者状态是只读的，避免并发修改问题。
2. 线程安全考虑：如果单例会被多线程访问，必须确保线程安全，Kotlin 的 object 关键字天然线程安全。
3. 生命周期明确：单例的生命周期应该与应用程序一致，不需要手动销毁和重建。
4. 依赖关系简单：单例不应该依赖太多外部资源，避免复杂的初始化逻辑。
5. 测试友好：考虑到单元测试的需要，可以设计成可测试的形式，比如提供重置方法或使用依赖注入。
