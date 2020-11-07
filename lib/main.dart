import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hardwaremobile/providers/ProductProvider.dart';
import 'package:hardwaremobile/providers/UserProvider.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hardware-Mobile",
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapShot) {
            if (userSnapShot.hasData)
              return Shop();
            else
              return SigninScreen();
          },
        ),
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
      ),
    );
  }
}
