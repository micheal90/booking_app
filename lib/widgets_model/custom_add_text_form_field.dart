import 'package:flutter/material.dart';

import 'package:booking_app/widgets_model/custom_text.dart';

class CustomAddTextFormField extends StatelessWidget {
  String? label, hint,initialValue;
  Function? onSave;
  Function? validator;
  
  CustomAddTextFormField({
    this.label,
    this.hint,
    this.initialValue,
    this.onSave,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}
