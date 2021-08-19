import 'package:booking_app/Screens/login_screen.dart';
import 'package:booking_app/Screens/splash_screen.dart';
import 'package:booking_app/Screens/veiw_screens/bottom_navigation_bar_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlView extends StatelessWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, valueAuth, child) => valueAuth.isAuth
            ? BottomNavigationBarScreen()
            : FutureBuilder(
                future: valueAuth.tryAutoLogIn(),
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? SplashScreen()
                        : LoginScreen()));
  }
}
