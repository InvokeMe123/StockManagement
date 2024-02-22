import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:stockmgmt/features/auth/presentation/views/login_screen.dart';
import 'package:stockmgmt/features/register/data/data_source/auth_data_source.dart';
import 'package:stockmgmt/features/register/data/model/register_model.dart';
import 'package:stockmgmt/utils/custom_nav/app_nav.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  //api fetch
  //for JSON that doesnt have name , we need to make an array to store data of json array
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  //register api(Post API)
  void register(String email, password) async {
    try {
      Response response = await http.post(
          Uri.parse('https://reqres.in/api/register'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Account created");
        print(data['token']);
      } else {
        print("account not created");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
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
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    labelText: ' Confirm Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                        onPressed: _toggleConfirmPasswordVisibility,
                        icon: Icon(_isConfirmPasswordVisible
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
                      register(_emailController.text.toString(),
                          _passwordController.text.toString());
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //     child: FutureBuilder(
                //   future: getPostApi(),
                //   builder: ((context, snapshot) {
                //     if (!snapshot.hasData) {
                //       return Text('Loading');
                //     } else {
                //       return ListView.builder(
                //           shrinkWrap: true,
                //           itemCount: postList.length,
                //           itemBuilder: (context, index) {
                //             return Column(
                //               children: [
                //                 Row(
                //                   children: [
                //                     Text(index.toString()),
                //                     Container(
                //                       width: 200,
                //                       padding:
                //                           EdgeInsets.only(left: 10, right: 10),
                //                       child: Text(
                //                         postList[index].title.toString(),
                //                         style: TextStyle(
                //                             overflow: TextOverflow.ellipsis),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 Text(postList[index].body.toString()),
                //               ],
                //             );
                //           });
                //     }
                //   }),
                // )),
              ],
            )),
      ),
    );
  }
}
