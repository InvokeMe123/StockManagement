import 'dart:developer';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:intl/intl.dart';
import 'package:stockmgmt/features/items/presentation/controller/items_controller.dart';
import 'package:stockmgmt/utils/custom_snackbar/custom_snackbar.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

class AddItem extends ConsumerStatefulWidget {
  const AddItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem> {
  TextEditingController price = TextEditingController();

  TextEditingController count = TextEditingController();
  TextEditingController itemName = TextEditingController();
  String fileName = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PlatformFile? imagefile;

  String getFormattedMonth() {
    final now = DateTime.now();
    final formatter =
        DateFormat('MMMM'); // Use 'MMM' for abbreviated month names
    return formatter.format(now);
  }

  void pickFile() async {
    // Request storage permission if needed
    final storageStatus = await Permission.storage.request();
    if (!storageStatus.isGranted) {
      throw Exception('Storage permission is required to upload the image.');
    }

    // Use FilePicker to select an image
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    // Handle user interaction and potential errors
    if (result != null && result.files.isNotEmpty) {
      PlatformFile imageFile = result.files.single;
      setState(() {
        fileName =
            imageFile.name.split('-').first; // Extract filename (optional)
        imagefile = imageFile; // Store the PlatformFile object
      });
      print('File picked: ${imageFile.name}');
      log('File path: ${imageFile.path}');
      print('File size: ${imageFile.size}');
    } else {
      // Handle cases like user canceling the selection or errors
      print('No image selected.');
    }
  }

  Future<bool> uploadToFirebase(String itemName) async {
    User? user = FirebaseAuth.instance.currentUser;
    bool flag = false;

    if (user != null) {
      // Create a unique file name to prevent overwrites
      final ProgressDialog pr = ProgressDialog(context);
      pr.style(message: 'Uploading...');

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.${imagefile!.extension}';
      Reference storageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      try {
        pr.show();
        final uploadTask = storageRef.putFile(io.File(imagefile!.path!));
        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();
        log(downloadUrl);

        await users
            .doc(user.uid)
            .collection(getFormattedMonth())
            .doc(itemName)
            .set({
          'downloadUrl': downloadUrl,
          'itemName': itemName,
          'totalPcs': 0
        });
        pr.hide();
        flag = true;
        setState(() {});
      } catch (error) {
        print('Error uploading image: $error');
        rethrow;
      }
    }
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && fileName != '') {
                    uploadToFirebase(itemName.text).then((value) {
                      Navigator.pop(context);
                      ref.refresh(itemControllerProvider);
                    }).then((value) {
                      showCustomSnackBar('Successfully added', context,
                          isError: false);
                    });
                  }
                },
                child: Text('Add'),
              ),
            )
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: itemName,
                textCapitalization: TextCapitalization.words,
                validator: ((validator) {
                  if (itemName.text.isEmpty) {
                    return 'Item Name can\'t be empty';
                  }
                  return null;
                }),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: AppColorConst.kappprimaryColorBlue)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 1.5, color: CupertinoColors.destructiveRed)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 1,
                            color: AppColorConst.kappprimaryColorBlue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: AppColorConst.kappprimaryColorBlue)),
                    labelText: "Item Name",
                    prefixIcon: Icon(Icons.store)),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  pickFile();
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1, color: AppColorConst.kappprimaryColorBlue)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.image),
                      SizedBox(
                        width: 15,
                      ),
                      fileName == ''
                          ? Text(
                              'Select image',
                              style: TextStyle(fontSize: 16),
                            )
                          : Text('$fileName')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
