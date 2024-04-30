import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/features/items/presentation/views/widget/addItem.dart';
import 'package:stockmgmt/utils/items_type/items_card.dart';

class ItemScreen extends ConsumerStatefulWidget {
  const ItemScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemScreenState();
}

class _ItemScreenState extends ConsumerState<ItemScreen> {
  List<String> filteredItems = [];
  TextEditingController itemName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 244, 247),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.only(left: 25, top: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Items",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
              const SizedBox(
                height: 20,
              ),
              TextField(
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
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 90,
                        child: ItemCard(
                            itemType: "Rice", count: '20', price: '2400'));
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
