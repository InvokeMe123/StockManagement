import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/features/auth/presentation/views/login_screen.dart';

class StockMgmtApp extends ConsumerStatefulWidget {
  const StockMgmtApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<StockMgmtApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData.light().copyWith(
          dropdownMenuTheme: DropdownMenuThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  contentPadding: EdgeInsets.all(10),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                          width: 2, color: CupertinoColors.destructiveRed)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                          width: 2, color: AppColorConst.kappprimaryColorBlue)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                          width: 2, color: AppColorConst.kappprimaryColorBlue)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                          width: 2, color: AppColorConst.kappprimaryColorBlue)),
                  constraints: BoxConstraints.expand()))),
    );
  }
}
