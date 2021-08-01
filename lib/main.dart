import 'package:booking_app/Screens/login_screen.dart';
import 'package:booking_app/Screens/splash_screen.dart';
import 'package:booking_app/Screens/veiw_screens/bottom_navigation_bar_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences preferences = await SharedPreferences.getInstance();
  //preferences.clear();
  await Firebase.initializeApp();
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
        builder: (context, snapshot) => Consumer<AuthProvider>(
              builder: (context, valueAuth, child) => MaterialApp(
                title: 'Booking App',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: snapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : valueAuth.isAuth
                        ? BottomNavigationBarScreen()
                        : FutureBuilder(
                            future:  valueAuth.tryAutoLogIn(),
                            builder: (context, snapshot) =>
                                snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? SplashScreen()
                                    : LoginScreen()),
              ),
            ));
  }
}
