+++
date = '2025-07-18T10:09:02+08:00'
draft = false
title = 'ViewModel Demo'
tags = ['Kotlin','ViewModel']
categories = ['Android']
+++

## dependencies

```Kotlin
implementation(libs.androidx.lifecycle.viewmodel.ktx)
implementation(libs.androidx.lifecycle.livedata.ktx)
```

## 一个继承自 ViewModel 的类
```Kotlin
class MainViewModel : ViewModel() {
    private val _number = MutableStateFlow(100)
    val number: StateFlow<Int>
        get() = _number
}
```

## 使用它
```Kotlin
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            val mainViewModel: MainViewModel by viewModels()
            val numberState by mainViewModel.number.collectAsState()
            ViewModelDemoTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Greeting(
                        num = numberState, modifier = Modifier.padding(innerPadding)
                    )
                }
            }
        }
    }
}

@Composable
fun Greeting(num: Int, modifier: Modifier = Modifier) {
    Text(
        text = num.toString(),
        modifier = modifier
    )
}
```
