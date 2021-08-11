import 'package:booking_app/Screens/Profile_screen.dart';
import 'package:booking_app/Screens/devices_management_screen.dart';
import 'package:booking_app/Screens/schedule_planning.dart';
import 'package:booking_app/Screens/users_management_screen.dart';
import 'package:booking_app/Screens/reserved_devices_screen.dart';
import 'package:booking_app/Screens/veiw_screens/bottom_navigation_bar_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_list_tile.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<AuthProvider>(
              builder: (context, valueAuth, child) => Container(
                height: 100,
                padding:
                    EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: 'Admin App',
                      alignment: Alignment.center,
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: 'Logged as ', color: Colors.red[700]),
                        CustomText(
                          text:
                              '${valueAuth.adminModel!.name} ${valueAuth.adminModel!.lastName}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomListTile(
              title: 'Home',
              leading: Icon(Icons.home),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarScreen())),
            ),

            // CustomListTile(
            //     title: 'Add Planning',
            //     leading: Icon(Icons.playlist_add_rounded)),

            Divider(),
            CustomListTile(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => UsersManagementScreen())),
              title: 'Users Management',
              leading: Icon(Icons.attractions_outlined),
            ),
            CustomListTile(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => DevicesManagementScreen())),
              title: 'Divices Management',
              leading: Icon(Icons.app_registration),
            ),
            // CustomListTile(
            //   onTap: () => Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //           builder: (context) => CategoriesManagementScreen())),
            //   title: 'Categories Management',
            //   leading: Icon(Icons.margin),
            // ),
            CustomListTile(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => SchedulePlanningScreen())),
              title: 'Schedule Planning',
              leading: Icon(Icons.schedule),
            ),
            CustomListTile(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => ReservedDevicesScreen())),
                title: 'Reserved devices',
                leading: Icon(Icons.connect_without_contact)),
            CustomListTile(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProfileScreen())),
                title: 'Profile',
                leading: Icon(Icons.person))
          ],
        ),
      ),
    );
  }
}
