import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/features/items/presentation/controller/sold_purchased_controller.dart';

final soldPurchasedProvider =
    StateNotifierProvider<SoldPurchased, int>((ref) => SoldPurchased());
final soldHomeProvider =
    StateNotifierProvider<SoldHome, int>((ref) => SoldHome());
final purchasedHomeProvider =
    StateNotifierProvider<PurchasedHome, int>((ref) => PurchasedHome());

class ItemCard extends ConsumerStatefulWidget {
  final String itemType;
  final String count;
  final String price;
  const ItemCard(
      {required this.itemType, required this.count, required this.price});
  @override
  ConsumerState<ItemCard> createState() => ItemCardState();
}

class ItemCardState extends ConsumerState<ItemCard> {
  @override
  Widget build(BuildContext context) {
    var quantityCounter = ref.watch(soldPurchasedProvider);

    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.all(2),
          child: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 8),
                      child: Text(widget.itemType),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("Price per unit"),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text('$quantityCounter'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(widget.price),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  TextButton(
                      onPressed: () {
                        if (quantityCounter > 0) {
                          ref.read(soldPurchasedProvider.notifier).sold();
                          ref.read(soldHomeProvider.notifier).soldH();
                        } else {}
                      },
                      child: Text('Sold')),
                  TextButton(
                      onPressed: () {
                        ref.read(soldPurchasedProvider.notifier).purchased();
                        ref.read(purchasedHomeProvider.notifier).purchasedH();
                      },
                      child: Text('Added')),
                ]),
              ],
            ),
          )),
    ));
  }
}
