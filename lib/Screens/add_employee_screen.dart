import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _lastNController = TextEditingController();

  final TextEditingController _groupController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  final TextEditingController _phoneController = TextEditingController();
  bool isloading = false;
  void addEmployee(BuildContext context, AuthProvider value) async {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    setState(() {
      isloading = true;
    });
    try {
      await value.addEmplyee(
        name: _nameController.text.trim(),
        password: _passwordController.text.trim(),
        lastName: _lastNController.text.trim(),
        occupationGroup: _groupController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
      );
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Employee added')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isloading = false;
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
            child: Consumer<AuthProvider>(
              builder: (context, valueAuth, child) => Column(
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
                    isPassword: valueAuth.isShowPassword.value ? true : false,
                    suffixIcon: IconButton(
                      icon: valueAuth.isShowPassword.value
                          ? Icon(Icons.visibility_off_rounded)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        valueAuth.changeShowPassword();
                      },
                    ),
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
                  isloading
                      ? CircularProgressIndicator()
                      : CustomElevatedButton(
                          text: 'Add',
                          onPressed: () => addEmployee(context, valueAuth),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
