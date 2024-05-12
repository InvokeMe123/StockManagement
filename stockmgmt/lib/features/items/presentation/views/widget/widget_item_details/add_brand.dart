import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/features/items/data/data_source/items_data_source.dart';
import 'package:stockmgmt/features/items/presentation/controller/items_controller.dart';
import 'package:stockmgmt/utils/custom_snackbar/custom_snackbar.dart';

class AddBrand extends ConsumerWidget {
  final String itemName;
  const AddBrand({required this.itemName});

  @override
  Widget build(BuildContext context, ref) {
    TextEditingController count = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController brandName = TextEditingController();

    int calculateTotalPieces(List<DocumentSnapshot>? brands) {
      int totalPcs = 0;
      if (brands != null) {
        for (var brand in brands) {
          // Explicit cast to Map<String, dynamic>
          Map<String, dynamic>? brandData =
              brand.data() as Map<String, dynamic>?;

          // Check if brandData is not null and contains 'count' key
          if (brandData != null && brandData['count'] != null) {
            // Add the count of pieces for this brand to the total
            totalPcs += int.parse(brandData['count']);
          }
        }
      }
      return totalPcs;
    }

    Future<int> setPurchaseAmount(String price, String count) async {
      User? user = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      //for sold and purchase amount
      DocumentReference soldPurchased =
          users.doc(ref.watch(itemDataSourceProvider).getFormattedMonth());

      DocumentSnapshot purchaseAmountSnapshot = await soldPurchased.get();
      Map<String, dynamic> data2 =
          purchaseAmountSnapshot.data() as Map<String, dynamic>;
      int purchaseAmount = data2['purchaseAmount'] ?? 0;
      int currentPurchaseAmount =
          purchaseAmountSnapshot.exists ? (purchaseAmount) : 0;

      // Calculate the new purchase amount
      int newPurchaseAmount = int.parse(count) * int.parse(price);
      int updatedPurchaseAmount = currentPurchaseAmount + newPurchaseAmount;
      await soldPurchased.set({
        'purchaseAmount': updatedPurchaseAmount,
      });
      return updatedPurchaseAmount;
    }

    Future<void> addBrandToFirebase(
        String price, String brandName, String count) async {
      User? user = FirebaseAuth.instance.currentUser;
      final ProgressDialog pr =
          ProgressDialog(context, type: ProgressDialogType.Normal);
      pr.style(message: 'Uploading...');
      if (user != null) {
        pr.show();
        pr.style(message: 'Uploading...');

        //for users collection
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        //add brand to firebase
        DocumentReference itemRef = users
            .doc(user.uid)
            .collection(ref.watch(itemDataSourceProvider).getFormattedMonth())
            .doc(itemName);
        List<DocumentSnapshot>? brands = await ref
            .watch(itemControllerProvider.notifier)
            .fetchBrandDocument(itemName);
        int totalPcs = calculateTotalPieces(brands) + int.parse(count);

        // Check if the document exists
        bool itemExists = (await itemRef.get()).exists;

        if (!itemExists) {
          await itemRef.set({
            'downloadUrl': '',
            'itemName': itemName,
            'brandCount': 0,
            'totalPcs': count
          });
        }
        setPurchaseAmount(price, count);

        // Get the current brand count
        DocumentSnapshot itemSnapshot = await itemRef.get();
        Map<String, dynamic>? data =
            itemSnapshot.data() as Map<String, dynamic>?;

        int brandCount = data?['brandCount'] ?? 0;

        // Increment the brand count
        brandCount++;

        // Add the new brand details
        await itemRef.collection('brands').doc("brand $brandCount").set({
          'brandName': brandName,
          'price': price,
          'count': count,
        });

        // Update the brand count in the item document
        await itemRef.update({'brandCount': brandCount, 'totalPcs': totalPcs});
        pr.hide();
        Navigator.pop(context);
        showCustomSnackBar('Successfully added', context, isError: false);
      }
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text('Add Brand'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: brandName,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(8),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: CupertinoColors.destructiveRed)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1, color: AppColorConst.kappprimaryColorBlue)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                labelText: "Brand Name",
                prefixIcon: Icon(Icons.store)),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: count,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(8),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: CupertinoColors.destructiveRed)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1, color: AppColorConst.kappprimaryColorBlue)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                labelText: "Count",
                prefixIcon: Icon(Icons.tag)),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(8),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: CupertinoColors.destructiveRed)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1, color: AppColorConst.kappprimaryColorBlue)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                labelText: "Unit Price",
                prefixIcon: Icon(Icons.attach_money)),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                addBrandToFirebase(price.text, brandName.text, count.text);
              },
            ),
          )
        ],
      ),
    );
  }
}
