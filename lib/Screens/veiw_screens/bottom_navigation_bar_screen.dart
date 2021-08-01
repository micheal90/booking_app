import 'package:booking_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:booking_app/Screens/devices_management_screen.dart';
import 'package:booking_app/Screens/users_management_screen.dart';
import 'package:booking_app/Screens/veiw_screens/home_screen.dart';
import 'package:booking_app/providers/main_provider.dart';

import '../../constants.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  var currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    DevicesManagementScreen(),
    UsersManagementScreen()
  ];
  @override
  void initState() {
    Provider.of<MainProvider>(context, listen: false).getDevices();
    Provider.of<AuthProvider>(context, listen: false).getAdmin();
    Provider.of<AuthProvider>(context, listen: false).getEmployee();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
        selectedItemColor: KPrimaryColor,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Devices Manage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Users Manage',
          ),
        ],
      ),
    );
  }
}
