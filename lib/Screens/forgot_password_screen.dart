import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  void resetPassword(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .resetPassword(_emailController.text.trim());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Check your email inbox..')));
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              color: KPrimaryColor,
              child: Column(
                children: [
                  SizedBox(height: 60),
                  CustomText(
                    text: 'Reset Password',
                    color: Colors.white,
                    fontSize: 33,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.7,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          CustomText(
                            text: 'Enter your email address',
                            color: Colors.grey,
                            alignment: Alignment.center,
                            fontSize: 22,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'example@gmail.com',
                            isPassword: false,
                            prefixIcon: Icons.email,
                            suffixIcon: null,
                            type: TextInputType.emailAddress,
                            validate: (String? val) {
                              if (val!.isEmpty || !val.contains('@')) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          isLoading
                              ? CircularProgressIndicator()
                              : CustomElevatedButton(
                                  text: 'RESET PASSWORD',
                                  onPressed: () {
                                    resetPassword(context);
                                  },
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
