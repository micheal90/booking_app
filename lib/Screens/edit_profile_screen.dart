import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_add_text_form_field.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  void update(BuildContext context, AuthProvider valueAuth) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    try {
      await valueAuth.updateAdmin();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The data has been updated'),
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred, please try again'),
          duration: Duration(seconds: 5)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<AuthProvider>(
            builder: (context, valueAuth, child) => Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAddTextFormField(
                    initialValue: valueAuth.adminModel!.name,
                    label: 'Name',
                    onSave: (String? val) {
                      valueAuth.adminModel!.name = val!;
                    },
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Enter the name';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomAddTextFormField(
                    initialValue: valueAuth.adminModel!.lastName,
                    label: 'Last Name',
                    onSave: (String? val) {
                      valueAuth.adminModel!.lastName = val!;
                    },
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Enter the Last name';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  valueAuth.isLoading.value
                      ? CircularProgressIndicator()
                      : CustomElevatedButton(
                          text: 'Update',
                          onPressed: () => update(context, valueAuth),
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
