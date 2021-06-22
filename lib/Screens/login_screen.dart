import 'package:booking_app/Screens/forgot_password_screen.dart';
import 'package:booking_app/Screens/veiw_screens/home_screen.dart';
import 'package:booking_app/Screens/signup_screen.dart';
import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            color: KPrimaryColor,
            child: Column(
              children: [
                SizedBox(height: 60),
                
                CustomText(
                  text: 'Login',
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
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40,
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
                            onSave: (value) {
                              print('Email: $value');
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Consumer<AuthProvider>(
                          builder: (BuildContext context, value,
                                  Widget? child) =>
                              CustomTextFormField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  hint: "Minimum 6 characters",
                                  isPassword:
                                      value.isShowPassword.value ? true : false,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: IconButton(
                                    icon: value.isShowPassword.value
                                        ? Icon(Icons.visibility_off_rounded)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      //change show password state
                                      value.changeShowPassword();
                                    },
                                  ),
                                  type: TextInputType.text,
                                  validate: (String? val) {
                                    if (val!.isEmpty || val.length < 6) {
                                      return "Password is too short";
                                    }
                                    return null;
                                  },
                                  onSave: (value) {
                                    print('password: $value');
                                  }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPasswordScreen()));
                            },
                            child: CustomText(
                              text: 'Forgot Password?',
                              alignment: Alignment.centerRight,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        CustomElevatedButton(
                          text: 'LOGIN',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Don't have an account? ",
                            ),
                            TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => SignUpScreen())),
                                child: CustomText(
                                  text: 'Sign Up',
                                  color: KPrimaryColor,
                                ))
                          ],
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
    ));
  }
}
