import "package:flutter/material.dart";
import './screens/signin_screen.dart';
import './screens/signup_screen.dart';
import './screens/verify_screen.dart';
import './screens/detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/profile_screen.dart';
import './shop/shop.dart';

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
        '/detail': (context) => DetailScreen(),
        '/cart': (context) => CartScreen(),
        '/order': (context) => OrderScreen(),
        '/profile': (context) => ProfileScreen(),
        '/shop': (context) => Shop(),
      },
    );
  }
}
