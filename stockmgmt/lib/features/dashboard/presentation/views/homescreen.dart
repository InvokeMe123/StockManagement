import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stockmgmt/features/bar_graph/bar_graph.dart';
import 'package:stockmgmt/features/items/presentation/views/items.dart';
import 'package:stockmgmt/utils/custom_nav/app_nav.dart';
import 'package:stockmgmt/utils/items_type/items_card.dart';
import 'package:stockmgmt/widgets/customNavigationButton.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String userName = "Bibash";
  String soldQuantity = "10";
  String purchasedQuantity = "10";
  String earned = "100000";
  String spent = "20000";

  List<double> weeklySummary = [20, 30, 50, 10, 45, 33, 5];
  @override
  Widget build(BuildContext context) {
    //final quantitySoldPurchased = ref.read(soldPurchasedProvider);
    final quantitySoldHome = ref.read(soldHomeProvider);
    final quantityPurchasedHome = ref.read(purchasedHomeProvider);
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello " + userName + "!"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              top: 10,
              duration: const Duration(seconds: 4),
              width: width,
              child: Container(
                height: 200,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Today's Summary",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sold Quantity",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15),
                                ),
                                Text(
                                  '$quantitySoldHome',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Purchased Quantity",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15),
                                ),
                                Text(
                                  '$quantityPurchasedHome',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Earnings(Rs)",
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
                            const SizedBox(
                              width: 58,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Spendings(Rs)",
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
            ),
            AnimatedPositioned(
              top: 220,
              duration: const Duration(milliseconds: 5),
              child: Padding(
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
            ),
            AnimatedPositioned(
              top: 290,
              duration: const Duration(milliseconds: 10),
              child: Column(children: [
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
            ),
            Container(
              padding: const EdgeInsets.only(top: 350),
              child: SizedBox(
                height: 300,
                child: MyBarGraph(
                  weeklySummary: weeklySummary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
