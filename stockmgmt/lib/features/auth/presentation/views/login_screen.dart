import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:page_transition/page_transition.dart';
import 'package:stockmgmt/features/auth/auth_service/auth_service.dart';
import 'package:stockmgmt/features/auth/presentation/controller/auth_controller.dart';
import 'package:stockmgmt/features/auth/presentation/views/register.dart';

import 'package:stockmgmt/features/dashboard/presentation/views/homescreen.dart';
import 'package:stockmgmt/utils/bottom_bar/bottom_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> logIn(BuildContext context) async {
    await ref
        .read(authControllerProvider.notifier)
        .login(_emailController.text, _passwordController.text)
        .then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomBar(selectedIndex: 0)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DefaultTextStyle(
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Helvetica Neue"),
                    child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                      TypewriterAnimatedText(
                        "LOGIN",
                        speed: const Duration(milliseconds: 200),
                      )
                    ])),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: EmailValidator.validate,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid)),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                        onPressed: _togglePasswordVisibility,
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.black),
                    focusedBorder: const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                    enabledBorder: const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 45, 34, 214),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        logIn(context);
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: const Text("Create Account")),
                    const SizedBox(width: 80),
                    TextButton(
                      onPressed: () {
                        //password reset
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
