import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/const/app_images_const.dart';
import 'package:stockmgmt/features/items/presentation/controller/items_controller.dart';
import 'package:stockmgmt/features/items/presentation/views/widget/addItem.dart';
import 'package:stockmgmt/utils/items_type/item_types.dart';
import 'package:stockmgmt/utils/items_type/items_card.dart';
import 'package:stockmgmt/utils/loading_dialog.dart/loader_dialog.dart';

class ItemScreen extends ConsumerStatefulWidget {
  const ItemScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemScreenState();
}

class _ItemScreenState extends ConsumerState<ItemScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController itemName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final itemController = ref.read(itemControllerProvider.notifier);
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.white,
                  Colors.blue,
                  AppColorConst.kappprimaryColorBlue
                ]),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        toolbarHeight: height * .12,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 20, right: 10, bottom: 20),
            child: CupertinoSearchTextField(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            // child: TextField(
            //   decoration: InputDecoration(
            //       fillColor: Colors.white,
            //       filled: true,
            //       contentPadding: EdgeInsets.all(8),
            //       focusedErrorBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(18),
            //           borderSide: BorderSide(
            //               width: 1.5,
            //               color: AppColorConst.kappprimaryColorBlue)),
            //       errorBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(18),
            //           borderSide: BorderSide(
            //               width: 1.5, color: CupertinoColors.destructiveRed)),
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(18),
            //           borderSide: BorderSide(
            //               width: 1, color: AppColorConst.kappprimaryColorBlue)),
            //       focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(18),
            //           borderSide: BorderSide(
            //               width: 1.5,
            //               color: AppColorConst.kappprimaryColorBlue)),
            //       hintText: "Search Items",
            //       prefixIcon: Icon(Icons.search)),
            // ),
          ),
        ),
        title: Text(
          "Items",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AddItem();
                  });
            },
            icon: const Icon(Icons.add),
            color: Colors.black,
            iconSize: 30,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          itemController.fetchItemDocument();
          setState(() {});
        },
        child: FutureBuilder(
            future: itemController.fetchItemDocument(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.data!.isEmpty) {
                return Container(child: Center(child: Text('No items')));
              } else {
                List<DocumentSnapshot>? itemName = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 10),
                  child: Container(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of items in each row
                        crossAxisSpacing:
                            10, // Spacing between items horizontally
                        mainAxisSpacing: 10, // Spacing between items vertically
                        childAspectRatio:
                            0.8, // Aspect ratio of each item (width / height)
                      ),
                      shrinkWrap: true,
                      itemCount: itemName!.length,
                      itemBuilder: (context, index) {
                        if (itemName[index].data() != null) {
                          // Access the item name from the DocumentSnapshot
                          Map<String, dynamic>? itemData =
                              itemName[index].data() as Map<String, dynamic>?;
                          String? itemNameValue = itemData!['itemName'];
                          String? imageUrl = itemData['downloadUrl'];
                          int? brandCount = itemData['brandCount'];
                          int? totalPcs = itemData['totalPcs'];

                          return ItemType(
                            brandCount ?? 0,
                            itemNameValue ?? '',
                            4500,
                            4123,
                            imageUrl ?? '',
                            totalPcs ?? 0,
                          );
                        } else {
                          return Placeholder();
                        }
                      },
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
