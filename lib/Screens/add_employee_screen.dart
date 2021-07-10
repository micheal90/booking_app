import 'dart:io';

import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNController = TextEditingController();
  TextEditingController _groupController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _phoneController = TextEditingController();

  final picker = ImagePicker();
  bool isLoading = false;
  late File image;
  void add(BuildContext context) async {
    if (!_formkey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });
    await Provider.of<AuthProvider>(context, listen: false)
        .addEmplyee(
      name: _nameController.text.trim(),
      lastName: _lastNController.text.trim(),
      occupationGroup: _groupController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    )
        .then((value) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User added')));
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                CustomAddTextFormField(
                  controller: _nameController,
                  label: 'Name',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter name';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _lastNController,
                  label: 'Last Name',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter last name';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _groupController,
                  label: 'Occupation Group',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter Occupation Group';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  validator: (String? value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Enter a valid email';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _passwordController,
                  label: 'password',
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Enter a valid password';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAddTextFormField(
                  controller: _phoneController,
                  label: 'Phone',
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter phone';
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : CustomElevatedButton(
                        text: 'Add',
                        onPressed: () => add(context),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> pickedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Choose the profile image'),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.camera,
                        color: KPrimaryColor,
                      ),
                      title: Text('From Camera'),
                      onTap: () async {
                        await pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.photo_library,
                        color: KPrimaryColor,
                      ),
                      title: Text('From Gallery'),
                      onTap: () async {
                        await pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
      //save imagefile in db
    } else {
      print('No image selected.');
    }
  }
}
