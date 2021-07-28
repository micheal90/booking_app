import 'package:booking_app/Screens/forgot_password_screen.dart';
import 'package:booking_app/Screens/veiw_screens/bottom_navigation_bar_screen.dart';
import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/auth_provider.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;
  void submit(BuildContext context, AuthProvider value) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    try {
      await value.logInWithEmail(
          _emailController.text.trim(), _passwordController.text.trim());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()));
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(seconds: 5),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You can\'t login !\nThis email is not admin'),
          duration: Duration(seconds: 5)));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
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
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Consumer<AuthProvider>(
                          builder: (context, valueAuth, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
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

                              CustomTextFormField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  hint: "Minimum 6 characters",
                                  isPassword: valueAuth.isShowPassword.value
                                      ? true
                                      : false,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: IconButton(
                                    icon: valueAuth.isShowPassword.value
                                        ? Icon(Icons.visibility_off_rounded)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      valueAuth.changeShowPassword();
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

                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
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
                              isLoading
                                  ? CircularProgressIndicator()
                                  : CustomElevatedButton(
                                      text: 'LOGIN',
                                      onPressed: () =>
                                          submit(context, valueAuth),
                                    ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     CustomText(
                              //       text: "Don't have an account? ",
                              //     ),
                              //     TextButton(
                              //         onPressed: () => Navigator.of(context)
                              //             .pushReplacement(MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     SignUpScreen())),
                              //         child: CustomText(
                              //           text: 'Sign Up',
                              //           color: KPrimaryColor,
                              //         ))
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
