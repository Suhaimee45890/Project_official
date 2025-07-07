import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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

  Future<void> fetchProduct() async {
    final GetConnect fetch = GetConnect();

    Response response = await fetch.get(
      "https://world.openfoodfacts.org/api/v0/product/${barcode}.json",
    );
    if (response.body["status_verbose"] == "product not found") {
      image =
          "https://res.cloudinary.com/dzd7lt1ck/image/upload/v1751549893/product-not-found_wvlmoa.jpg";
    } else {
      image = response.body["product"]["image_front_url"].toString();
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> checkFirebase(String barcode) async {
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
    setState(() {
      isLoading = false;
    });
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
        child: SingleChildScrollView(
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
                decoration: InputDecoration(hint: Text("ใส่ชื่อ Product")),
              ),
              TextField(
                controller: barcodeController,
                decoration: InputDecoration(hint: Text(barcodeController.text)),
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
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("Cancle")),
                    ElevatedButton(
                      onPressed: () {
                        addData();
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
              image!,
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
