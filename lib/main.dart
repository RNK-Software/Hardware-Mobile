import "package:flutter/material.dart";
import './screens/signin_screen.dart';
import './screens/signup_screen.dart';
import './screens/verify_screen.dart';
import './screens/home_screen.dart';
import './screens/category_screen.dart';
import './screens/detail_screen.dart';

void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hardware-Mobile",
      home: StreamBuilder(builder:(ctx, userSnapShot) {
          return SigninScreen();
      } ,),
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.amber),
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        accentColor: Colors.white,
      ),
      routes: {
        '/signin': (context) => SigninScreen(),
        '/signup': (context) => SignupScreen(),
        '/verify': (context) => VerificationScreen(),
        '/home': (context) => HomeScreen(),
        '/category': (context) => CategoryScreen(),
        '/detail': (context) => DetailScreen(),
      },
    );
  }
}
