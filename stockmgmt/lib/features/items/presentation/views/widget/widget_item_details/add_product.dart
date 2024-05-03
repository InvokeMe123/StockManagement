import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmgmt/const/app_color_const.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController count = TextEditingController();
    TextEditingController price = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text('Add Item?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: count,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(8),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: CupertinoColors.destructiveRed)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1, color: AppColorConst.kappprimaryColorBlue)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                labelText: "Count",
                prefixIcon: Icon(Icons.tag)),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(8),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: CupertinoColors.destructiveRed)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1, color: AppColorConst.kappprimaryColorBlue)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 1.5, color: AppColorConst.kappprimaryColorBlue)),
                labelText: "Price",
                prefixIcon: Icon(Icons.attach_money)),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}