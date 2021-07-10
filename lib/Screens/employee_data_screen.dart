import 'package:booking_app/Screens/employees_management_screen.dart';
import 'package:booking_app/Screens/veiw_screens/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:booking_app/models/employee_model.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_list_tile_profile.dart';
import 'package:booking_app/widgets_model/custom_text.dart';

class EmployeeDataScreen extends StatefulWidget {
  final String employeeId;
  EmployeeDataScreen(
    this.employeeId,
  );

  @override
  _EmployeeDataScreenState createState() => _EmployeeDataScreenState();
}

class _EmployeeDataScreenState extends State<EmployeeDataScreen> {
  EmployeeModel? employeeModel;

  @override
  void initState() {
    employeeModel = Provider.of<MainProvider>(context, listen: false)
        .findEmployeeById(widget.employeeId);
    super.initState();
  }

  void deleteUser(BuildContext context, String id) {
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
              text: 'The Employee will be deleted',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('No')),
                Consumer<MainProvider>(
                  builder: (context, value, child) => TextButton(
                      onPressed: () async {
                        await value.deleteEmployee(id).then((val) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Employee deleted')));
                          value.removeFromSearchList(id);
                        }).then((val) => Navigator.of(context).pop());
                      },
                      child: Text('Yes')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Data'),
        centerTitle: true,
      ),
      body: Consumer<MainProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              CustomListTileProfile(
                leading: Icon(Icons.person),
                title: 'Name',
                subtitle: employeeModel!.name + ' ' + employeeModel!.lastName,
              ),
              CustomListTileProfile(
                leading: Icon(Icons.group_rounded),
                title: 'Occupation Group',
                subtitle: employeeModel!.occupationGroup,
              ),
              CustomListTileProfile(
                leading: Icon(Icons.email),
                title: 'Email',
                subtitle: employeeModel!.email,
              ),
              CustomListTileProfile(
                leading: Icon(Icons.phone),
                title: 'Phone',
                subtitle: employeeModel!.phone,
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () => deleteUser(context, employeeModel!.id),
                  child: CustomText(
                    alignment: Alignment.center,
                    text: 'Delete Employee',
                    color: Colors.red,
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
