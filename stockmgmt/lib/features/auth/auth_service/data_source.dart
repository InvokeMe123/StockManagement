import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockmgmt/core/db_client/db_client.dart';

class DataSource {
  Future<String?> getUserName(String uid) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Create a reference to the users collection
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        // Query the document corresponding to the user's UID
        DocumentSnapshot doc = await users.doc(user.uid).get();

        // Extract the name from the document data
        String? userName = doc.get('userName');

        return userName;
      } else {
        print('User not logged in');
        return null;
      }
    } catch (e) {
      print('Error getting user name: $e');
      return null;
    }
  }

  Future<String?> getStoreName(String uid) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Create a reference to the users collection
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        // Query the document corresponding to the user's UID
        DocumentSnapshot doc = await users.doc(user.uid).get();

        // Extract the name from the document data
        String? storeName = doc.get('storeName');

        return storeName;
      } else {
        print('User not logged in');
        return null;
      }
    } catch (e) {
      print('Error getting user name: $e');
      return null;
    }
  }
}
