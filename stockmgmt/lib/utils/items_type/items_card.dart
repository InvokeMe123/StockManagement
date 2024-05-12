import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/features/items/presentation/controller/sold_purchased_controller.dart';
import 'package:stockmgmt/features/items/presentation/views/widget/widget_item_details/add_product.dart';
import 'package:stockmgmt/features/items/presentation/views/widget/widget_item_details/sell_product.dart';



class ItemCard extends ConsumerStatefulWidget {
  final String brandName;
  final String brandCount;
  final String brandPrice;
  final String imageUrl;
  const ItemCard(
      {required this.brandName,
      required this.brandCount,
      required this.brandPrice,
      required this.imageUrl});
  @override
  ConsumerState<ItemCard> createState() => ItemCardState();
}

class ItemCardState extends ConsumerState<ItemCard> {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.all(2),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.all(10),
            tileColor: AppColorConst.kappFadedBlue,
            title: Text(
              widget.brandName,
              style: TextStyle(
                  fontFamily: 'PS',
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w900),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.brandCount + ' pcs',
                  style: TextStyle(
                      fontFamily: 'Gabarito',
                      fontSize: 15,
                      letterSpacing: .9,
                      fontWeight: FontWeight.w200),
                ),
                Text(
                  'Rs. ' + widget.brandPrice,
                  style: TextStyle(
                      fontFamily: 'Gabarito',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AddProduct();
                        });
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                        fontFamily: 'Gabarito',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return SellProduct();
                        });
                  },
                  child: Text("Sell",
                      style: TextStyle(
                          fontFamily: 'Gabarito',
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            leading: Image(image: NetworkImage(widget.imageUrl)),
          )),
    ));
  }
}
