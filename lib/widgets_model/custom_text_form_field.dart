import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String label;
  String hint;
  bool isPassword;
  IconData prefixIcon;
  Widget? suffixIcon;
  TextInputType type;
  String? Function(String?)? validate;
  Function(String?)? onSave;
  CustomTextFormField({
     this.controller,
    required this.label,
    required this.hint,
    required this.isPassword,
    required this.prefixIcon,
     this.suffixIcon,
    required this.type,
    required this.validate,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      onSaved: onSave,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
