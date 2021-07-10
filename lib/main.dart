import 'package:booking_app/Screens/login_screen.dart';
import 'package:booking_app/Screens/splash_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AuthProvider()),
      ChangeNotifierProvider.value(value: MainProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) => MaterialApp(
          title: 'Booking App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: snapshot.connectionState == ConnectionState.waiting
              ? SplashScreen()
              : DoubleBack(
                  child: LoginScreen(),
                )),
    );
  }
}
