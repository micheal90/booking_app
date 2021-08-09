import 'package:booking_app/Screens/add_admin.dart';
import 'package:booking_app/Screens/add_employee_screen.dart';
import 'package:booking_app/Screens/admin_data_screen.dart';
import 'package:booking_app/Screens/employee_data_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class UsersManagementScreen extends StatelessWidget {
  void deleteUser(BuildContext context, String id, bool isAdmin) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: CustomText(
                text: 'Are you sure',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: 'The user will be deleted',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('No')),
                      TextButton(
                        onPressed: () async => isAdmin
                            ? await deletAdmin(context,id)
                            : await deleteEmployee(context,id),
                        child: Text('Yes'),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

  Future deleteEmployee(BuildContext context,String id) async {
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .deleteEmployee(id);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Employee deleted')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future deletAdmin(BuildContext context,String id) async {
    try {
      await Provider.of<AuthProvider>(context, listen: false).deleteAdmin(id);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Admin deleted')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Users Management'),
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.manage_accounts),
              )
            ]),
          ),
          body: TabBarView(children: [
            employeeBody(),
            adminBody(),
          ]),
          floatingActionButton: buildFloatingActionButton(context),
          drawer: MainDrawer(),
        ),
      ),
    );
  }

  Padding employeeBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AuthProvider>(
        builder: (context, valueAuth, child) => valueAuth.employeeList.isEmpty
            ? Center(
                child: CustomText(
                  text: 'No employee has been added yet',
                  fontSize: 30,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EmployeeDataScreen(
                              employeeId: valueAuth.employeeList[index].id))),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade400,
                            backgroundImage: valueAuth
                                        .employeeList[index].imageUrl ==
                                    ''
                                ? NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fprofile.png?alt=media&token=51affe95-e779-4cd0-8085-fef095c86062')
                                : NetworkImage(
                                    valueAuth.employeeList[index].imageUrl)),
                        title: CustomText(
                          text: valueAuth.employeeList[index].name +
                              ' ${valueAuth.employeeList[index].lastName}',
                        ),
                        subtitle: CustomText(
                          color: Colors.grey,
                          text:
                              '${valueAuth.employeeList[index].email} \n${valueAuth.employeeList[index].phone}',
                        ),
                        isThreeLine: true,
                        trailing: GestureDetector(
                            onTap: () => deleteUser(context,
                                valueAuth.employeeList[index].id, false),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: valueAuth.employeeList.length),
      ),
    );
  }

  Padding adminBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AuthProvider>(
        builder: (context, valueAuth, child) => valueAuth.adminList.isEmpty
            ? Center(
                child: CustomText(
                  text: 'No admin has been added yet',
                  fontSize: 30,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminDataScreen(
                              adminId: valueAuth.adminList[index].id))),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade400,
                            backgroundImage: NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fprofile.png?alt=media&token=51affe95-e779-4cd0-8085-fef095c86062')),
                        title: CustomText(
                          text: valueAuth.adminList[index].name +
                              ' ${valueAuth.adminList[index].lastName}',
                        ),
                        subtitle: CustomText(
                          color: Colors.grey,
                          text: '${valueAuth.adminList[index].email}',
                        ),
                        isThreeLine: false,
                        trailing: GestureDetector(
                            onTap: () => deleteUser(
                                context, valueAuth.adminList[index].id, true),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: valueAuth.adminList.length),
      ),
    );
  }

  SpeedDial buildFloatingActionButton(BuildContext context) {
    return SpeedDial(
      marginEnd: 18,
      marginBottom: 20,
      icon: Icons.add,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,
      closeManually: false,
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.blue,
      foregroundColor: Colors.black,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.person),
          //backgroundColor: Colors.red,
          label: 'Add Employee',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEmployeeScreen(),
          )),
        ),
        SpeedDialChild(
            child: Icon(Icons.manage_accounts),
            backgroundColor: Colors.red,
            label: 'Add Admin',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddAdmin(),
                ))),
      ],
    );
  }
}
