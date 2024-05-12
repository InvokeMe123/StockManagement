import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stockmgmt/core/db_client/db_client.dart';
import 'package:stockmgmt/features/bar_graph/new_graph.dart';
import 'package:stockmgmt/features/auth/auth_service/data_source.dart';
import 'package:stockmgmt/features/items/data/data_source/items_data_source.dart';
import 'package:stockmgmt/features/items/presentation/controller/items_controller.dart';
import 'package:stockmgmt/features/items/presentation/controller/sold_purchased_controller.dart';
import 'package:stockmgmt/features/items/presentation/views/items.dart';
import 'package:stockmgmt/utils/custom_nav/app_nav.dart';
import 'package:stockmgmt/utils/items_type/items_card.dart';
import 'package:stockmgmt/utils/shimmer/shimmer.dart';
import 'package:stockmgmt/widgets/customNavigationButton.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String soldQuantity = "10";
  String purchasedQuantity = "10";
  String earned = "100000";
  String spent = "20000";
  String? userName;
  String? storeName;
  DataSource ds = DataSource();

  Future getData() async {
    String uid = await DbClient().getData('uid');
    userName = await ds.getUserName(uid);
    storeName = await ds.getStoreName(uid);
  }

  List<double> weeklySummary = [20, 30, 50, 10, 45, 33, 5];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final quantitySoldPurchased = ref.watch(soldPurchasedProvider);

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator while waiting for data
            return Column(
              children: [
                ShimmerSkeleton(count: 1, height: 25),
                ShimmerSkeleton(count: 1, height: 200),
                ShimmerSkeleton(count: 1, height: 45),
                ShimmerSkeleton(count: 1, height: 151),
                ShimmerSkeleton(count: 1, height: 10),
                ShimmerSkeleton(count: 1, height: 10),
              ],
            );
          } else if (snapshot.hasError) {
            // Handle any errors that occur during data fetching
            return Text('Error fetching data: ${snapshot.error}');
          } else {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("Hello $userName !"),
                backgroundColor: Colors.white,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height * .20,
                        margin: const EdgeInsets.only(left: 17, right: 17),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromARGB(255, 45, 34, 214)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ref
                                          .watch(itemDataSourceProvider)
                                          .getFormattedMonth() +
                                      '\'s' +
                                      " Summary",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  "$storeName",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Text(
                                  "${DateFormat('EEEE, d MMMM y').format(DateTime.now())}",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Earnings(Rs)",
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          earned,
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Spendings(Rs)",
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          spent,
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            customNavigationButton(
                                icon: Icons.shopping_bag,
                                label: "All items",
                                value: "10",
                                onPressed: () {
                                  normalNav(context, ItemScreen());
                                }),
                            const SizedBox(
                              width: 40,
                            ),
                            customNavigationButton(
                                icon: Icons.person,
                                label: "All Contacts",
                                value: "5",
                                onPressed: () {})
                          ],
                        ),
                      ),
                      Column(children: [
                        Container(
                          margin: const EdgeInsets.all(12),
                          child: Text(
                            "Analytics",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ]),
                      // Container(
                      //   padding: const EdgeInsets.only(top: 350),
                      //   child: SizedBox(
                      //     height: 300,
                      //     child: MyBarGraph(
                      //       weeklySummary: weeklySummary,
                      //     ),
                      //   ),
                      // )
                      SizedBox(
                        height: height * .40,
                        width: width,
                        child: BarGraph(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
