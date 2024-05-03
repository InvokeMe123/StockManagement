import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockmgmt/core/db_client/db_client.dart';
import 'package:stockmgmt/features/auth/auth_service/data_source.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await DbClient().setData('uid', user!.uid);

      String b = await DbClient().getData('uid');
      log("Register:$b");
      return true;
      // Registration successful, userCredential.user will contain the user information
    } catch (e) {
      // Registration failed, throw an error
      throw FirebaseAuthException(
        message: 'Registration failed. Please try again.',
        code: 'registration_failed',
      );
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;

        //
        await storeUserData(uid);

        // Log success message
        log('Login successful: $uid');

        return true;
      } else {
        // User is null, handle error
        throw FirebaseAuthException(
          code: 'user_null',
          message: 'User is null after signing in.',
        );
      }
    } catch (e) {
      log('Login failed: $e');
      throw FirebaseAuthException(
        code: 'login_failed',
        message: 'Login failed. Please check your email and password.',
      );
    }
  }

  Future<void> storeUserData(String uid) async {
    DataSource ds = DataSource();
    await DbClient().setData('uid', uid);
    String? userName = await ds.getUserName(uid);
    String? storeName = await ds.getStoreName(uid);
    await DbClient().setData('userName', userName ?? '');
    await DbClient().setData('storeName', storeName ?? '');
  }

  Future<void> addUserToFirestore(String storeName, String userName) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Store user data locally (optional)
        await DbClient().setData('storeName', storeName);
        await DbClient().setData('userName', userName);

        // Create a reference to the users collection in Firestore
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        // Add user data to Firestore
        await users.doc(user.uid).set({
          'uuid': user.uid,
          'storeName': storeName,
          'userName': userName,
        });

        // Log success message
        print('User data added to Firestore');
      } else {
        print('User not logged in');
      }
    } catch (e) {
      // Handle errors that occur during data storage or Firestore operations
      print('Error adding user data to Firestore: $e');
    }
  }

  Future<bool> signOutUser() async {
    try {
      // Sign out the user
      await _auth.signOut();

      // Clear local data (if needed)
      await DbClient().clearAllData();

      // Log success message
      print('User logged out successfully');

      // Return true to indicate successful sign-out
      return true;
    } catch (e) {
      // Handle errors that occur during sign-out
      print('Error signing out: $e');

      // Return false to indicate sign-out failure
      return false;
    }
  }
}
