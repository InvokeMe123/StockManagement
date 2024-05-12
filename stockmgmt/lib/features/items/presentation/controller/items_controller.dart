import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/features/items/data/data_source/items_data_source.dart';

class ItemController extends StateNotifier<List<DocumentSnapshot>> {
  final ItemsDataSource itemsDataSource;

  ItemController(this.itemsDataSource) : super([]) {
   
  }
  Future<void> initialize(String itemName) async {
    try {
      // Fetch data from the data source
      final result = await itemsDataSource.fetchBrandDocuments(itemName);
      // Update the state with the fetched data
      state = result;
    } catch (error) {
      // Handle error if any
      print("Error initializing data: $error");
    }
  }

  Future<void> _fetchInitialData() async {
    try {
      // Fetch data from the data source
      final result = await itemsDataSource.fetchItemDocuments();
      // Update the state with the fetched data
      state = result;
    } catch (error) {
      // Handle error if any
      print("Error fetching initial data: $error");
    }
  }

  Future<void> _fetchBrandData(String itemName) async {
    try {
      // Fetch data from the data source
      final result = await itemsDataSource.fetchBrandDocuments(itemName);
      // Update the state with the fetched data
      state = result;
    } catch (error) {
      // Handle error if any
      print("Error fetching initial data: $error");
    }
  }

  Future<List<DocumentSnapshot>> fetchBrandDocument(String itemName) async {
    final result = await itemsDataSource.fetchBrandDocuments(itemName);
    state = result;
    return state;
  }

  Future<List<DocumentSnapshot>> fetchItemDocument() async {
    final result = await itemsDataSource.fetchItemDocuments();
    state = result;
    return state;
  }
}

final itemControllerProvider =
    StateNotifierProvider<ItemController, List<DocumentSnapshot>>((ref) {
  return ItemController(ref.watch(itemDataSourceProvider));
});
