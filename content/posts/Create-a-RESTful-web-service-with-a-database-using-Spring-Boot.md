+++
date = '2025-06-23T19:43:54+08:00'
draft = false
tags = ['Kotlin','Spring Boot']
categories = ['Kotlin','Web Service']
title = 'Create a RESTful Web Service With a Database Using Spring Boot'
+++

## 没有什么比官方教程更好的了

[官方链接](https://kotlinlang.org/docs/jvm-get-started-spring-boot.html)

## 那就做个简单的 demo 方便以后查询

1. 创建项目，添加依赖

- Web | Spring Web
- SQL | Spring Data JDBC
- SQL | H2 Database

2. 创建数据类

```Kotlin
@Table("TASKS")
data class Task(val name: String, @Id var id: String? = null)
```

3. 创建 `Controller` 层

```Kotlin
@RestController
@RequestMapping("/")
class TaskController(private val service: TaskService) {
    @GetMapping
    fun listTasks() = ResponseEntity.ok(service.findTasks())

    @GetMapping("/{id}")
    fun getTaskById(@PathVariable id: String) = service.findTaskById(id).toResponseEntity()

    @DeleteMapping("/{id}")
    fun delete(@PathVariable id: String) = service.deleteTaskById(id)

    @PostMapping
    fun post(@RequestBody task: Task): ResponseEntity<Task> {
        val savedTask = service.save(task)
        return ResponseEntity.created(URI("/${savedTask.id}")).body(savedTask)
    }

    private fun Task?.toResponseEntity() = this?.let { ResponseEntity.ok(it) } ?: ResponseEntity.notFound().build()

}
```

4. 创建数据库接口

```Kotlin
interface TaskRepository : CrudRepository<Task, String>
```

5. 实现`Service`层

```Kotlin
@Service
class TaskService(private val db: TaskRepository) {
    fun findTasks(): List<Task> = db.findAll().toList()

    fun findTaskById(id: String): Task? = db.findByIdOrNull(id)

    fun save(task: Task): Task = db.save(task)

    fun deleteTaskById(id: String) = db.deleteById(id)
}
```

6. 创建数据库初始化脚本
   在 src/main/resources/schema.sql 创建：

```sql
CREATE TABLE IF NOT EXISTS tasks (
  id VARCHAR(60) DEFAULT RANDOM_UUID() PRIMARY KEY,
  name VARCHAR NOT NULL
);
```

7. 配置`application.properties`

```properties
spring.application.name=demo
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.url=jdbc:h2:file:./data/testdb
spring.datasource.username=name
spring.datasource.password=password
spring.sql.init.schema-locations=classpath:schema.sql
spring.sql.init.mode=always
```

这里的 name 是项目名称，第三行的数据库 URL 有两种选择：

- `jdbc:h2:mem:testdb` - 内存数据库，重启后数据消失，适合开发测试
- `jdbc:h2:file:./data/testdb` - 文件数据库，数据持久化，适合需要保存数据的场景

推荐开发阶段使用内存模式，避免数据库文件冲突问题。

## 替换 JDBC 为 JPA

如果你和我一样不想创建 SQL 脚本，那么可以使用 JPA

1. 删除 SQL 脚本文件
2. 更新`Task.kt`文件

```Kotlin
@Entity
@Table(name = "TASKS")
data class Task(
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    var id: String? = null,
    val name: String
)
```

3. 更新配置 `application.properties`

```properties
spring.application.name=demo3
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.url=jdbc:h2:mem:testdb
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
spring.datasource.username=name
spring.datasource.password=password

```

`spring.jpa.hibernate.ddl-auto=create-drop`意味着启动时根据实体类（@Entity）自动创建所有表结构; 关闭时自动删除所有表结构（DROP TABLE）。

`spring.jpa.show-sql=true`意味着是否在控制台打印 Hibernate 执行的 SQL 语句。

这两个配置在**生产模式**下绝对**不适合开启**
