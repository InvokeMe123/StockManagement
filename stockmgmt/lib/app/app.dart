import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/core/db_client/db_client.dart';
import 'package:stockmgmt/features/auth/presentation/controller/auth_controller.dart';
import 'package:stockmgmt/features/auth/presentation/views/login_screen.dart';
import 'package:stockmgmt/features/dashboard/presentation/views/homescreen.dart';
import 'package:stockmgmt/utils/bottom_bar/bottom_bar.dart';

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
      home: ref.watch(authControllerProvider).when(
          loggedIn: (data) {
            log(data);
            return const BottomBar(
              selectedIndex: 0,
            );
          },
          loading: () => const CircularProgressIndicator(),
          loggedOut: () => const LoginScreen()),
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
