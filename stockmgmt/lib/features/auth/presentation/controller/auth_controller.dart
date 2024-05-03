import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/core/db_client/db_client.dart';
import 'package:stockmgmt/features/auth/auth_service/auth_service.dart';
import 'package:stockmgmt/features/auth/auth_service/data_source.dart';
import 'package:stockmgmt/features/auth/presentation/controller/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  DbClient dbClient;
  AuthController(this.dbClient) : super(const AuthState.loading()) {
    checkLogin();
  }
  checkLogin() async {
    final String? dbResult = await dbClient.getData("uid");
    // log(dbResult);

    if (dbResult == null || dbResult.isEmpty) {
      state = const AuthState.loggedOut();
    } else {
      state = AuthState.loggedIn(dbResult);
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await AuthService().signInWithEmailAndPassword(email, password);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        state = AuthState.loggedIn(uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error logging in: $e');
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await AuthService().registerWithEmailAndPassword(email, password).then((value) {
       
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        state = AuthState.loggedIn(uid);
        return true;
      } else {
        return false;
      }
      });
      return true;
    } catch (e) {
      print('Error logging out: $e');
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await AuthService().signOutUser();

      state = const AuthState.loggedOut();
      return true;
    } catch (e) {
      print('Error logging out: $e');
      return false;
    }
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.read(dbClientprovider));
});
