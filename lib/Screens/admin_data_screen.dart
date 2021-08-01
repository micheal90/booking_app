import 'package:booking_app/models/admin_model.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_list_tile_profile.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDataScreen extends StatefulWidget {
  const AdminDataScreen({
    Key? key,
    required this.adminId,
  }) : super(key: key);
  final String adminId;
  @override
  _AdminDataScreenState createState() => _AdminDataScreenState();
}

class _AdminDataScreenState extends State<AdminDataScreen> {
  AdminModel? adminModel;
  @override
  void initState() {
    adminModel = Provider.of<AuthProvider>(context, listen: false)
        .findAdminById(widget.adminId);
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
                    text: 'The Admin will be deleted',
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
                        onPressed: () async => await deleteAdmin(id),
                        child: Text('Yes'),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

  deleteAdmin(String id) async {
    try {
      await Provider.of<AuthProvider>(context, listen: false).deleteAdmin(id);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Admin deleted')));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Data'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            CustomListTileProfile(
              leading: Icon(Icons.person),
              title: 'Name',
              subtitle: adminModel!.name + ' ' + adminModel!.lastName,
            ),
            CustomListTileProfile(
              leading: Icon(Icons.email),
              title: 'Email',
              subtitle: adminModel!.email,
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () => deleteUser(context, adminModel!.id),
                child: CustomText(
                  alignment: Alignment.center,
                  text: 'Delete Admin',
                  color: Colors.red,
                ))
          ]),
        ),
      ),
    );
  }
}
