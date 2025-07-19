+++
date = '2025-07-19T10:53:36+08:00'
draft = false
title = 'Navigation Compose Demo'
tags = ['Kotlin','Navigation-compose']
categories = ['Android']
+++

## Dependencies

```Kotlin
implementation("androidx.navigation:navigation-compose:2.9.2")
```

## Use

```Kotlin
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            val navController = rememberNavController()
            NavigationDemoApp(navController)
        }
    }
}

@Composable
fun NavigationDemoApp(navController: NavHostController) {
    NavHost(navController = navController, startDestination = "screen1") {
        composable("screen1") { Screen1(navController) }
        composable("screen2") { Screen2(navController) }
    }
}

@Composable
fun Screen1(navController: NavController) {
    Column(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = "Screen 1")
        Button(onClick = { navController.navigate("screen2") }) {
            Text(text = "Go to Screen 2")
        }
    }
}

@Composable
fun Screen2(navController: NavController) {
    Column(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = "Screen 2")
        Button(onClick = { navController.popBackStack() }) {
            Text(text = "Go back")
        }
    }
} 
```

## 官方指南

https://developer.android.com/develop/ui/compose/navigation