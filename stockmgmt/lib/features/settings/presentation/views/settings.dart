import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/features/auth/auth_service/auth_service.dart';
import 'package:stockmgmt/features/auth/presentation/controller/auth_controller.dart';
import 'package:stockmgmt/features/auth/presentation/views/login_screen.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text('SignOut'),
        onPressed: () {
          ref.read(authControllerProvider.notifier).logout().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) => const LoginScreen()));
          });
        },
      )),
    );
  }
}
