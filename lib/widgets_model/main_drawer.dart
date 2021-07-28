import 'package:booking_app/Screens/categories_mangement.dart';
import 'package:booking_app/Screens/devices_management_screen.dart';
import 'package:booking_app/Screens/employees_management_screen.dart';
import 'package:booking_app/Screens/login_screen.dart';
import 'package:booking_app/Screens/planning_management.dart';
import 'package:booking_app/Screens/reserved_devices_screen.dart';
import 'package:booking_app/Screens/veiw_screens/bottom_navigation_bar_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_list_tile.dart';
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
            AppBar(
              title: Text("Booking App"),
              automaticallyImplyLeading: true,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.menu)),
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
                      builder: (context) => EmployeeManagementScreen())),
              title: 'Employees Management',
              leading: Icon(Icons.attractions_outlined),
            ),
            CustomListTile(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => DevicesManagementScreen())),
              title: 'Divices Management',
              leading: Icon(Icons.app_registration),
            ),
            CustomListTile(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => CategoriesManagementScreen())),
              title: 'Categories Management',
              leading: Icon(Icons.margin),
            ),
            CustomListTile(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => PlanningManagementScreen())),
              title: 'Planning Management',
              leading: Icon(Icons.schedule),
            ),
            CustomListTile(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => ReservedDevicesScreen())),
                title: 'Reserved devices',
                leading: Icon(Icons.connect_without_contact)),
            IconButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logOut()
                      .then((value) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => LoginScreen())),);
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
