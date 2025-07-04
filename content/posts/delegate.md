+++
date = '2025-06-30T18:13:11+08:00'
draft = false
title = 'Delegate'
tags = ['Kotlin','Delegate']
categories = ['Kotlin','Basic']
+++

```kotlin
class Delegate {
    val name: String = "default"

    operator fun getValue(thisRef: Any?, property: KProperty<*>): String {
        return "getValue"
    }

    operator fun setValue(thisRef: Any?, property: KProperty<*>, value: String) {
        println("$value 已被赋值给 ${property.name} 于 $thisRef")
    }
}

class Example() {
    var name: String by Delegate()
}

fun main() {
    val e = Example()
    println(e.name) // getValue
    e.name = "hello" // hello 已被赋值给 name 于 org.example.Example@27973e9b
}
```

1. `KProperty<*>`  是表示属性元数据的接口，它包含了属性的名称、类型、注解等信息。
2. `thisRef`  指向`Example`类的实例。
3. `getValue` 返回值是`String`是因为在这个例子中，`name` 属性是 `String`。**属性类型与  `getValue`  返回值类型必须一致。**
