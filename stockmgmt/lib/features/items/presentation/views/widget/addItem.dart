import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/utils/custom_textField/custom_text_field.dart';
import 'package:stockmgmt/utils/items_type/items_card.dart';

class AddItem extends ConsumerStatefulWidget {
  const AddItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem> {
  List<String> items = ["Rice", "Oil", "Gas"];
  List<String> riceBrands = ["Upakar", "Dhanlaxmi", "Goodluck", "Pearl"];
  List<String> oilBrands = ["Aarati", "Fortune", "Dhara"];
  List<String> gasBrands = ["Narayani", "STC", "Nepal"];

  String? selectedItem;
  String? selectedBrand;
  bool isPreviousBrand = false;
  bool isNewBrand = false;

  TextEditingController price = TextEditingController();

  TextEditingController count = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: AlertDialog(
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            title: Container(
                decoration: BoxDecoration(
                    color: AppColorConst.kappprimaryColorBlue.withOpacity(.8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )),
                padding: EdgeInsets.all(10),
                child: Text(
                  'Add Item',
                  style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8),
                )),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            actions: [
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Add'),
                ),
              )
            ],
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   children: [
                //     SizedBox(
                //       height: 24,
                //       width: 24,
                //       child: RoundCheckBox(
                //         isChecked: isNewBrand,
                //         onTap: (selected) {
                //           setState(() {
                //             isNewBrand = selected!;
                //           });
                //         },
                //         size: 60,
                //         checkedWidget: Icon(
                //           Icons.check,
                //           size: 18,
                //           color: Colors.white,
                //         ),
                //         uncheckedColor: Colors.white,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Text(
                //       'New brand',
                //       style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.black,
                //           fontWeight: FontWeight.normal,
                //           letterSpacing: 0.8),
                //     )
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: AppColorConst.kappprimaryColorBlue,
                        width: 1), // Add border here
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(6),
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      hint: Text('Item Type'),

                      isExpanded: true,
                      value: selectedItem, // Set the default value here
                      onChanged: (String? newValue) {
                        // Handle dropdown item selection
                        print("Selected: $newValue");
                        setState(() {
                          selectedItem = newValue;
                          selectedBrand = null;
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                selectedItem == items[0]
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: AppColorConst.kappprimaryColorBlue,
                              width: 1), // Add border here
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(6),
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            hint: Text('Item Type'),

                            isExpanded: true,
                            value: selectedBrand, // Set the default value here
                            onChanged: (String? newValue) {
                              // Handle dropdown item selection
                              print("Selected: $newValue");
                              setState(() {
                                selectedBrand = newValue;
                              });
                            },
                            items: riceBrands
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : selectedItem == items[1]
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColorConst.kappprimaryColorBlue,
                                  width: 1), // Add border here
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(6),
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                hint: Text('Item Type'),

                                isExpanded: true,
                                value:
                                    selectedBrand, // Set the default value here
                                onChanged: (String? newValue) {
                                  // Handle dropdown item selection
                                  print("Selected: $newValue");
                                  setState(() {
                                    selectedBrand = newValue;
                                  });
                                },
                                items: oilBrands.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        : selectedItem == items[2]
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: AppColorConst.kappprimaryColorBlue,
                                      width: 1), // Add border here
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    borderRadius: BorderRadius.circular(6),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    hint: Text('Item Type'),

                                    isExpanded: true,
                                    value:
                                        selectedBrand, // Set the default value here
                                    onChanged: (String? newValue) {
                                      // Handle dropdown item selection
                                      print("Selected: $newValue");
                                      setState(() {
                                        selectedBrand = newValue;
                                      });
                                    },
                                    items: gasBrands
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : Container(),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: price,
                  labelText: 'Price per unit',
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: count,
                  labelText: 'Quantity',
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                ),
              ],
            )));
  }
}
