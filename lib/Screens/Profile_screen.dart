import 'package:booking_app/Screens/edit_profile_screen.dart';
import 'package:booking_app/Screens/login_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_list_tile_profile.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile Screen'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => EditProfileScreen())),
                child: CustomText(
                  text: 'Edit',
                  alignment: Alignment.center,
                  color: Colors.white,
                ))
          ],
        ),
        body: Consumer<AuthProvider>(
          builder: (context, valueAuth, child) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                CustomListTileProfile(
                  leading: Icon(Icons.person),
                  title: 'Name',
                  subtitle: valueAuth.adminModel!.name +
                      ' ' +
                      valueAuth.adminModel!.lastName,
                ),
                
                CustomListTileProfile(
                  leading: Icon(Icons.email),
                  title: 'Email',
                  subtitle: valueAuth.adminModel!.email,
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                    onPressed: () {
                      valueAuth.logOut().then((value) => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          )));
                    },
                    icon: Icon(Icons.logout),
                    label: CustomText(
                      text: 'Log Out',
                      color: Colors.red,
                    ))
              ]),
            ),
          ),
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
