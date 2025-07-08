import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_official/app/controller/upload_pic.dart';

class AfterScan extends StatefulWidget {
  const AfterScan({super.key});

  @override
  State<AfterScan> createState() => _AfterScanState();
}

class _AfterScanState extends State<AfterScan> {
  late TextEditingController nameController;
  late TextEditingController barcodeController;

  final String barcode = Get.arguments;
  bool isLoading = true;
  bool message = false;
  String? name;
  bool? isHalal;
  String? image;
  bool halal = false;
  bool? isFound;
  String? imagePath;
  bool upLoading = false;

  Future<void> checkFirebase(String barcode) async {
    isLoading = true;
    DocumentSnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection("products")
        .doc(barcode)
        .get();

    // Get.snackbar("title", response.exists.toString());
    if (response.exists) {
      image = response["image"];
      name = response["name"];
      isHalal = response["is_halal"];
      isFound = true;
    } else {
      isFound = false;
    }
    isLoading = false;

    setState(() {});
  }

  Future<void> addData() async {
    final barcode = barcodeController.text;
    final cldUrl = await UploadImg().uploadToCld(imagePath!);
    await FirebaseFirestore.instance.collection("products").doc(barcode).set({
      "name": nameController.text,
      "image": cldUrl,
      "is_halal": halal,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirebase(barcode);
    nameController = TextEditingController();
    barcodeController = TextEditingController();
    barcodeController.text = barcode;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : isFound!
        ? found()
        : notFound();
  }

  Scaffold notFound() {
    return Scaffold(
      appBar: AppBar(title: Text("Product not found")),
      body: Center(
        child: upLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    imagePath == null
                        ? ElevatedButton(
                            onPressed: () async {
                              imagePath = await UploadImg().pickImage();
                              setState(() {});
                            },
                            child: Text("Upload Image"),
                          )
                        : Image.file(
                            File(imagePath!),
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error_outline),
                          ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hint: Text("ใส่ชื่อ Product"),
                      ),
                    ),
                    TextField(
                      controller: barcodeController,
                      decoration: InputDecoration(
                        hint: Text(barcodeController.text),
                      ),
                    ),
                    DropdownButton<bool>(
                      value: halal,
                      onChanged: (value) {
                        setState(() {
                          halal = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(value: true, child: Text("Halal")),
                        DropdownMenuItem(value: false, child: Text("No")),
                      ],
                    ),
                    if (imagePath != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed("/scanner");
                            },
                            child: Text("Cancle"),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                upLoading = true;
                              });
                              await addData();
                              setState(() {
                                upLoading = false;
                              });
                              Get.offNamed("/scanner");
                            },
                            child: Text("Upload"),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Scaffold found() {
    return Scaffold(
      appBar: AppBar(title: Text("Product found")),
      body: Center(
        child: Column(
          children: [
            Image.network(
              image ?? "",
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
            Text(name ?? "name not found"),
            Text(barcode),
            Text(isHalal.toString()),
          ],
        ),
      ),
    );
  }
}
