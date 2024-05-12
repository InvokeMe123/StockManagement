import 'package:flutter/material.dart';
import 'package:stockmgmt/const/app_color_const.dart';

void showCustomSnackBar(String message, BuildContext context,
    {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isError ? Colors.red : AppColorConst.kappprimaryColorBlue,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    content: Text(
      message,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
    duration: const Duration(seconds: 4),
  ));
}
