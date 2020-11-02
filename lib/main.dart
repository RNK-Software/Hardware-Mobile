import "package:flutter/material.dart";
import './screens/signin_screen.dart';

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
        // '/register': (context) => Register(),
        // '/homescreen': (context) => HomeScreen(),
        // '/login': (context) => Login()
      },
    );
  }
}
