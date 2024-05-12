import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/features/items/presentation/controller/items_controller.dart';
import 'package:stockmgmt/features/items/presentation/views/widget/addItem.dart';
import 'package:stockmgmt/features/items/presentation/views/widget/widget_item_details/add_brand.dart';
import 'package:stockmgmt/utils/items_type/items_card.dart';

class ItemDetailScreen extends ConsumerStatefulWidget {
  final String itemName;

  const ItemDetailScreen({super.key, required this.itemName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemDetailScreen> {
  List<String> filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  String getFormattedMonth() {
    final now = DateTime.now();
    final formatter =
        DateFormat('MMMM'); // Use 'MMM' for abbreviated month names
    return formatter.format(now);
  }

  Future<List<DocumentSnapshot>> fetchDocuments() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<DocumentSnapshot> documents = [];

    if (user != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await users
          .doc(user.uid)
          .collection(getFormattedMonth())
          .doc(widget.itemName)
          .collection('brands')
          .get();
      documents.addAll(querySnapshot.docs);
    }
    return documents;
  }

  @override
  void initState() {
    super.initState();

    fetchDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = ref.read(itemControllerProvider.notifier);
    ref.read(itemControllerProvider.notifier).initialize(widget.itemName);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.itemName,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.black,
          iconSize: 23,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AddBrand(itemName: widget.itemName);
                  }).then((value) => setState(() {}));
            },
            icon: const Icon(Icons.add),
            color: Colors.black,
            iconSize: 30,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.only(left: 25, top: 20, right: 20),
          child: RefreshIndicator(
            onRefresh: () => itemProvider.fetchBrandDocument(widget.itemName),
            child: FutureBuilder(
                future: itemProvider.fetchBrandDocument(widget.itemName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<DocumentSnapshot>? brands = snapshot.data;
                    return Column(
                      children: [
                        TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color:
                                          AppColorConst.kappprimaryColorBlue)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: CupertinoColors.destructiveRed)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color:
                                          AppColorConst.kappprimaryColorBlue)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color:
                                          AppColorConst.kappprimaryColorBlue)),
                              hintText: "Search Items",
                              prefixIcon: Icon(Icons.search)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            itemCount: brands!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (brands[index].data() != null) {
                                Map<String, dynamic>? brandData = brands[index]
                                    .data() as Map<String, dynamic>;
                                String? brandName = brandData['brandName'];
                                String? brandCount = brandData['count'];
                                String? price = brandData["price"];
                                return Container(
                                  height: 100,
                                  // width: 200,
                                  child: ItemCard(
                                      brandName: brandName ?? '',
                                      brandCount: brandCount ?? '',
                                      brandPrice: price ?? '',
                                      imageUrl:
                                          "https://bpazes.com/_next/image?url=https%3A%2F%2Fbpazes-images.s3.ap-south-1.amazonaws.com%2Fupakar-classic-basmati-20kg-c2780605-f0b8-40d7-9ab1-9a83f6b9f94c%2Fcropped%2Fx2%2Flg%2Fimg_SDm--r3TQ7.jpeg&w=96&q=75"),
                                );
                              }
                              return null;
                            }),
                      ],
                    );
                  }
                }),
          ),
        )),
      ),
    );
  }
}
