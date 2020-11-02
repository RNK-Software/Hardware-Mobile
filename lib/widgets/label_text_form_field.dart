import 'package:flutter/material.dart';

class LabelTextFormField extends StatelessWidget {
  final String labelText;
  final bool isObscure;
  final controller;
  final TextInputType keyboardType;

  LabelTextFormField({
    this.isObscure = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText
  });

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: 8.0),
      child: TextFormField(
        obscureText: isObscure,
        controller: controller,
        validator: (String value) {
          if (value.isEmpty) {
            return labelText+" is required";
          }
          return null;
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 0),
              // add padding to adjust icon
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.4),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),)
        ),
      ),
    );
  }
}
