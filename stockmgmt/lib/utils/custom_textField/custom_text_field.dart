import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmgmt/const/app_color_const.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.textInputType,
      required this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.all(9),
        labelText: labelText,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide:
                BorderSide(width: 2, color: CupertinoColors.destructiveRed)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1, color: AppColorConst.kappprimaryColorBlue)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                width: 1, color: AppColorConst.kappprimaryColorBlue)),
      ),
    );
  }
}
