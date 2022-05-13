import 'package:booking_app/Screens/splash_screen.dart';
import 'package:booking_app/control_view.dart';
import 'package:booking_app/firebase_options.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/providers/connectivity_provider.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/Screens/no_internet_connection_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences preferences = await SharedPreferences.getInstance();
  //preferences.clear();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
          value: ConnectivityProvider()..startMonitoring()),
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
        builder: (context, snapshot) => Consumer<ConnectivityProvider>(
              builder: (context, valueConnectivity, child) => MaterialApp(
                title: 'Booking App',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    appBarTheme: AppBarTheme(titleSpacing: 0)),
                home: snapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : valueConnectivity.isOnline
                        ? ControlView()
                        : NoInternetConnectionScreen(),
              ),
            ));
  }
}
