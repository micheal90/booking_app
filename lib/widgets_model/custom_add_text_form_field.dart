import 'package:flutter/material.dart';

import 'package:booking_app/widgets_model/custom_text.dart';

class CustomAddTextFormField extends StatelessWidget {
  final String? label, hint, initialValue;
  Function? onSave;
  Function? validator;
  TextEditingController? controller;
  TextInputType? keyboardType;

  CustomAddTextFormField({
    this.controller,
    this.label,
    this.hint,
    this.keyboardType,
    this.initialValue,
    this.onSave,
    this.validator,
  });

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
          )),
      keyboardType: keyboardType,
    );
  }
}
