import 'package:booking_app/Screens/add_admin.dart';
import 'package:booking_app/Screens/add_employee_screen.dart';
import 'package:booking_app/Screens/employee_data_screen.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class EmployeeManagementScreen extends StatefulWidget {
  @override
  _EmployeeManagementScreenState createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  bool _isSearch = false;

  TextEditingController? searchController = TextEditingController();

  //List<EmployeeModel> searchList = [];

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
                TextButton(
                    onPressed: () async {
                      await Provider.of<MainProvider>(context, listen: false)
                          .deleteEmployee(id)
                          .then((value) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Employee deleted')));
                      });
                    },
                    child: Text('Yes')),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: _isSearch
              ? Consumer<MainProvider>(
                  builder: (context, value, child) => TextField(
                    autofocus: true,
                    controller: searchController,
                    onChanged: (val) {
                      setState(() {
                        value.searchList = value.employeeList.where((element) {
                          return (element.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase())) ||
                              (element.lastName
                                  .toLowerCase()
                                  .contains(val.toLowerCase()));
                        }).toList();
                      });
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: " Search...",
                        border: InputBorder.none,
                        // errorBorder: InputBorder.none,
                        //focusedBorder: InputBorder.none,
                        //enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(10)),
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Text('Employees Management'),
          actions: [
            IconButton(
                icon: _isSearch
                    ? Icon(Icons.cancel_outlined)
                    : Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearch = !_isSearch;
                    searchController!.clear();
                  });
                  Provider.of<MainProvider>(context, listen: false).searchList =
                      [];
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<MainProvider>(
            builder: (context, value, child) => value.employeeList.isEmpty
                ? Center(
                    child: CustomText(
                      text: 'No employee has been added yet',
                      fontSize: 30,
                      alignment: Alignment.center,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) => searchController!
                            .text.isNotEmpty
                        ? GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => EmployeeDataScreen(
                                        value.searchList[index].id))),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey.shade400,
                                  backgroundImage: value
                                              .searchList[index].imageUrl ==
                                          ''
                                      ? NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fprofile.png?alt=media&token=51affe95-e779-4cd0-8085-fef095c86062')
                                      : NetworkImage(
                                          value.searchList[index].imageUrl)),
                              title: CustomText(
                                text: value.searchList[index].name +
                                    ' ${value.searchList[index].lastName}',
                              ),
                              subtitle: CustomText(
                                color: Colors.grey,
                                text:
                                    '${value.searchList[index].email} \n${value.searchList[index].phone}',
                              ),
                              isThreeLine: true,
                              trailing: GestureDetector(
                                  onTap: () => deleteUser(
                                      context, value.searchList[index].id),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => EmployeeDataScreen(
                                        value.employeeList[index].id))),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey.shade400,
                                  backgroundImage: value
                                              .employeeList[index].imageUrl ==
                                          ''
                                      ? NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fprofile.png?alt=media&token=51affe95-e779-4cd0-8085-fef095c86062')
                                      : NetworkImage(
                                          value.employeeList[index].imageUrl)),
                              title: CustomText(
                                text: value.employeeList[index].name +
                                    ' ${value.employeeList[index].lastName}',
                              ),
                              subtitle: CustomText(
                                color: Colors.grey,
                                text:
                                    '${value.employeeList[index].email} \n${value.employeeList[index].phone}',
                              ),
                              isThreeLine: true,
                              trailing: GestureDetector(
                                  onTap: () => deleteUser(
                                      context, value.employeeList[index].id),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          ),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: searchController!.text.isNotEmpty
                        ? value.searchList.length
                        : value.employeeList.length),
          ),
        ),
        floatingActionButton: SpeedDial(
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
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
