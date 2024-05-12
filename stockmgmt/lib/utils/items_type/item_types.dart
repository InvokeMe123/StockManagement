import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/const/app_images_const.dart';
import 'package:stockmgmt/features/items/presentation/views/items_details.dart';
import 'package:stockmgmt/utils/custom_nav/app_nav.dart';

class ItemType extends ConsumerStatefulWidget {
  final int brandCount;
  final int totalItems;
  final String itemName;
  final int soldAmt;
  final int purchasedAmt;
  final String image;

  ItemType(this.brandCount, this.itemName, this.soldAmt, this.purchasedAmt,
      this.image, this.totalItems,
      {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemTypeState();
}

class _ItemTypeState extends ConsumerState<ItemType> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Container(
      height: height * .27,
      width: width * .45,
      child: InkWell(
        onTap: () {
          normalNav(
              context,
              ItemDetailScreen(
                itemName: widget.itemName,
              ));
        },
        child: Card(
          color: Colors.white,
          elevation: 8,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: height * 0.13,
                    width: width * .24,
                    child: Image(
                      image: NetworkImage(
                        widget.image,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(widget.itemName,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kanit')),
                Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.totalItems.toString() + " pcs",
                          style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.systemGrey,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Kanit')),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.circle_outlined,
                        size: 8,
                        color: CupertinoColors.systemGrey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.brandCount.toString() + " brands",
                          style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.systemGrey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Kanit')),
                    ]),
                Text(
                  "Sold: Rs." + widget.soldAmt.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Kanit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
