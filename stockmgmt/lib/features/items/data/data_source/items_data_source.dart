import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ItemsDataSource{
  String getFormattedMonth() {
    final now = DateTime.now();
    final formatter =
        DateFormat('MMMM'); // Use 'MMM' for abbreviated month names
    return formatter.format(now);
  }
  Future<List<DocumentSnapshot>> fetchBrandDocuments(String itemName) async {
    User? user = FirebaseAuth.instance.currentUser;
    List<DocumentSnapshot> documents = [];

    if (user != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await users
          .doc(user.uid)
          .collection(getFormattedMonth())
          .doc(itemName)
          .collection('brands')
          .get();
      documents.addAll(querySnapshot.docs);
    }
    return documents;
  }
  
  Future<List<DocumentSnapshot>> fetchItemDocuments() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<DocumentSnapshot> documents = [];
    if (user != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await users
          .doc(user.uid)
          .collection(getFormattedMonth()) // Assuming the month is a collection
          .get();

      documents.addAll(querySnapshot.docs);

      return documents;
    } else {
      return [];
    }
  }
  
  
}

final itemDataSourceProvider = StateProvider<ItemsDataSource>((ref) {
  return ItemsDataSource();
});