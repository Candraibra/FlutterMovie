import 'package:beginner_submission/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamMovie',
      theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 24,
            ),
            titleMedium: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
