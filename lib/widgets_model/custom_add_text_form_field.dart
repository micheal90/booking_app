import 'package:flutter/material.dart';

class CustomAddTextFormField extends StatelessWidget {
  final String? label, hint, initialValue;
  final Function? onSave;
  final Function? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Widget? suffixIcon;

  CustomAddTextFormField(
      {this.controller,
      this.label,
      this.hint,
      this.keyboardType,
      this.initialValue,
      this.onSave,
      this.validator,
      this.suffixIcon,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onSaved: onSave as void Function(String?)?,
      validator: validator as String? Function(String?)?,
      decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: suffixIcon),
      keyboardType: keyboardType,
      obscureText: isPassword!,
    );
  }
}
