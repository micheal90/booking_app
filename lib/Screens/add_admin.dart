import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _lastNController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey();
  bool isLoading = false;

  void add(BuildContext context) {
    if (!_formkey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    Provider.of<MainProvider>(context, listen: false)
        .addAddmin(
      name: _nameController.text.trim(),
      lastName: _lastNController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    )
        .then((value) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Addmin added')));
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Addmin"),
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
}
