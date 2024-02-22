import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/const/app_fonts.dart';
import 'package:stockmgmt/const/app_images_const.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        toolbarHeight: 70,
        backgroundColor: AppColorConst.kappFadedBlue,
      ),
      body: Container(
          color: AppColorConst.kappFadedBlue,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return HistoryLists(
                date: DateFormat('d MMM yy').format(DateTime.now()).toString(),
                itemType: 'Rice',
                price: 2342,
                quantity: 8,
              );
            },
          )),
    );
  }
}

class HistoryLists extends StatelessWidget {
  final String itemType;
  final int price;
  final int quantity;
  final String date;
  HistoryLists(
      {super.key,
      required this.itemType,
      required this.price,
      required this.quantity,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(date),
          Container(
            child: Text(''),
          )
        ],
      ),
    );
  }
}

class VerticalLine extends StatelessWidget {
  const VerticalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3, // Adjust width as needed
      height: 50, // Adjust height as needed
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0), // Transparent color at the start
            Colors.black
                .withOpacity(0.5), // Semi-transparent color in the middle
            Colors.black.withOpacity(0), // Transparent color at the end
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
