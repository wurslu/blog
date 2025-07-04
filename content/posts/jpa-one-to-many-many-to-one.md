+++
date = '2025-07-05T02:45:02+08:00'
draft = false
title = 'JPA OneToMany 和 ManyToOne 超简单入门示例'
tags = ['Kotlin','OneToMany','ManyToOne']
categories = ['Kotlin','Web Service']
+++

## 什么是 OneToMany 和 ManyToOne？

- **OneToMany（一对多）**：一个东西可以对应多个另一个东西，比如一个用户有多个好友关系
- **ManyToOne（多对一）**：多个东西对应一个东西，比如多个好友关系都属于同一个用户

## 用好友关系举例理解

### **1. 用户实体（One 方）**

```Kotlin
@Entity
data class User {
@Id
var id: Long? = null
var username: String = ""

    // 一个用户有多个好友关系，mappedBy 指向关联的属性名
    @OneToMany(mappedBy = "user")
    var friendRelations: List<Friendship> = emptyList()

}
```

### **2. 好友关系实体（Many 方）**

```Kotlin
@Entity
data class Friendship {
@Id
var id: Long? = null

    // 多个好友关系属于一个用户，@JoinColumn 定义外键列
    @ManyToOne
    @JoinColumn(name = "user_id")
    var user: User? = null

    var friendId: Long = 0

}
```

## 核心配置一句话解释

- **@OneToMany**：放在 "一" 的那一方，告诉 JPA 这个东西可以有多个关联对象
- **mappedBy = "user"**：表示关联关系由对方（Friendship）的 user 属性维护
- **@ManyToOne**：放在 "多" 的那一方，表示这个东西属于另一个东西
- **@JoinColumn(name = "user_id")**：在数据库表中创建 user_id 列作为外键
