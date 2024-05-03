import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockmgmt/const/app_color_const.dart';
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
  TextEditingController itemName = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    return AddBrand();
                  });
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
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: AppColorConst.kappprimaryColorBlue)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                            width: 1.5, color: CupertinoColors.destructiveRed)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                            width: 1,
                            color: AppColorConst.kappprimaryColorBlue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: AppColorConst.kappprimaryColorBlue)),
                    hintText: "Search Items",
                    prefixIcon: Icon(Icons.search)),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      // width: 200,
                      child: ItemCard(
                          brandName: 'Upakar',
                          brandCount: "3",
                          brandPrice: "2400",
                          imageUrl:
                              "https://bpazes.com/_next/image?url=https%3A%2F%2Fbpazes-images.s3.ap-south-1.amazonaws.com%2Fupakar-classic-basmati-20kg-c2780605-f0b8-40d7-9ab1-9a83f6b9f94c%2Fcropped%2Fx2%2Flg%2Fimg_SDm--r3TQ7.jpeg&w=96&q=75"),
                    );
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
