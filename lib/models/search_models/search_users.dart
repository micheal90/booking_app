import 'package:booking_app/Screens/admin_data_screen.dart';
import 'package:booking_app/Screens/employee_data_screen.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchUsers extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchList = Provider.of<AuthProvider>(context).allUsers;

    final suggestionList = searchList
        .where((element) =>
            element.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          if (suggestionList[index].runtimeType.toString() == 'EmployeeModel') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => EmployeeDataScreen(
                        employeeId: suggestionList[index].id)));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        AdminDataScreen(adminId: suggestionList[index].id)));
          }
        },
        leading: Icon(Icons.person),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].name.substring(0, query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].name.substring(query.length),
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
