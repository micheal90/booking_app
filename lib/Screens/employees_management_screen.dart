import 'package:booking_app/models/user_model.dart';
import 'package:booking_app/providers/home_provider.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeManagementScreen extends StatelessWidget {
  final List<UserModel> usersList = [
    UserModel(
        id: 'id',
        name: 'micheal',
        lastName: 'Hana',
        occupationGroup: 'IT department',
        email: 'michealhana@gmail.com',
        imageUrl: ['assets/images/profile.png'],
        phone: '+96181488287'),
    UserModel(
        id: 'id',
        name: 'micheal',
        lastName: 'Hana',
        occupationGroup: 'HR',
        email: 'michealhana@gmail.com',
        imageUrl: ['assets/images/profile.png'],
        phone: '+96181488287')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Employees Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemBuilder: (context, index) => Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      size: 35,
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      size: 35,
                    ),
                  ),
                  onDismissed: (direction) {
                    Provider.of<HomeProvider>(context, listen: false)
                        .deleteEmployee();
                  },
                  child: ListTile(
                      leading: CircleAvatar(
                        child: CustomText(
                          color: Colors.white,
                          alignment: Alignment.center,
                          text: usersList[index].occupationGroup.substring(0, 2),
                        ),
                      ),
                      title: CustomText(
                        text: usersList[index].name +
                            ' ${usersList[index].lastName}',
                      ),
                      subtitle: CustomText(
                        text: usersList[index].email,
                      ),
                      trailing: Text(
                        usersList[index].phone,
                      )),
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: usersList.length),
      ),
    );
  }
}
