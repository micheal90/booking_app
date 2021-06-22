import 'package:booking_app/Screens/add_device.dart';
import 'package:booking_app/Screens/add_employee_screen.dart';
import 'package:booking_app/Screens/devices_management_screen.dart';
import 'package:booking_app/Screens/reserved_devices_screen.dart';
import 'package:booking_app/widgets_model/custom_list_tile.dart';
import 'package:flutter/material.dart';

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
              // leading: IconButton(
              //     onPressed: () => Navigator.of(context).pop(),
              //     icon: Icon(Icons.menu)),
            ),
            CustomListTile(
              title: 'Add Employee',
              leading: Icon(Icons.person_add_sharp),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddEmployeeScreen())),
            ),
            CustomListTile(
              title: 'Add Device',
              leading: Icon(Icons.devices_sharp),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddDeviceScreen())),
            ),
            CustomListTile(
                title: 'Add Planning',
                leading: Icon(Icons.playlist_add_rounded)),
            CustomListTile(
                title: 'Add Admin', leading: Icon(Icons.manage_accounts)),
            Divider(),
            CustomListTile(
              title: 'Employees Management',
              leading: Icon(Icons.attractions_outlined),
            ),
            GestureDetector(
              onTap:()=> Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DevicesManagementScreen())),
                          child: CustomListTile(
                title: 'Divice Management',
                leading: Icon(Icons.app_registration),
              ),
            ),
            CustomListTile(
              title: 'Planning Management',
              leading: Icon(Icons.margin),
            ),
            GestureDetector(
              onTap:()=> Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ReservedDevicesScreen())),
                          child: CustomListTile(
                  title: 'Reserved devices',
                  leading: Icon(Icons.connect_without_contact)),
            ),
          ],
        ),
      ),
    );
  }
}
