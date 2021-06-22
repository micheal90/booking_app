import 'package:booking_app/Screens/add_employee_screen.dart';
import 'package:booking_app/Screens/add_device.dart';
import 'package:booking_app/Screens/reserved_devices_screen.dart';
import 'package:booking_app/Screens/veiw_screens/home_screen.dart';
import 'package:booking_app/Screens/login_screen.dart';
import 'package:booking_app/Screens/splash_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AuthProvider()),
      ChangeNotifierProvider.value(value: HomeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) => MaterialApp(
        title: 'Booking App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: snapshot.connectionState == ConnectionState.waiting
            ? SplashScreen()
            : HomeScreen()
      ),
    );
  }
}
