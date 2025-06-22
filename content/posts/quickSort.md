+++
date = '2025-06-22T16:43:19+08:00'
draft = false
title = '快速排序'
+++

指针版本看不懂？没关系，跟我一起"魔修"这个简化版本！重点是掌握分治思想，而不是纠结于内存管理的细节。

## 复杂度分析

**时间复杂度**：O(n log n) - 平均情况下每次都能均匀分割  
**空间复杂度**：O(n) - 比标准版本的 O(log n) 更大，因为需要创建新列表

## 主要思路

1. 随便选一个数作为基准值，比如数组中间的数。
2. 分别找出比这个基准值大，中，小的所有元素，此时有三部分。
3. 对每一部分再次执行步骤二，把最基本的结果进行连接，得到排序后的序列。
4. 每一部分一直执行步骤二，那么终止条件是什么呢，显然是，待排序的序列只有一个元素，那么此时，不需要再进行排序了。

## 示例代码

```Kotlin
fun quickSort(list: List<Int>): List<Int> {
    if (list.size <= 1) return list // 递归终止条件

    val base = list[list.size / 2] // 随便选一个基准值，这里选中间的元素
    val small = list.filter { it < base } // 找出比基准值小的元素
    val equal = list.filter { it == base } // 找出与基准值相等大小的元素
    val large = list.filter { it > base } // 找出比基准值大的元素

    return quickSort(small) + equal + quickSort(large) // 递归分别处理每一部分，将结果进行拼接
}
```
