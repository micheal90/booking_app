import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _lastNController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  bool isLoading = false;

  void addAdmin(BuildContext context, AuthProvider value) async {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    try {
      await value.addAdmin(
        name: _nameController.text.trim(),
        lastName: _lastNController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Admin added')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Addmin"),
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
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : CustomElevatedButton(
                          text: 'Add',
                          onPressed: () => addAdmin(context, valueAuth),
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
