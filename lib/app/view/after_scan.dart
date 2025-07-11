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
  bool? isFound;
  String? name;
  bool? isHalal;
  String? image;
  bool halal = false;
  String? imagePath;
  bool upLoading = false;

  Future<void> checkFirebase(String barcode) async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection("products")
        .doc(barcode)
        .get();

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
    final barcodeText = barcodeController.text;
    final cldUrl = await UploadImg().uploadToCld(imagePath!);
    await FirebaseFirestore.instance
        .collection("products")
        .doc(barcodeText)
        .set({
          "name": nameController.text.trim(),
          "image": cldUrl,
          "is_halal": halal,
        });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    barcodeController = TextEditingController(text: barcode);
    checkFirebase(barcode);
  }

  @override
  void dispose() {
    nameController.dispose();
    barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Loading...")),
        body: const Center(child: CircularProgressIndicator()),
      );
    } else {
      return isFound == true ? _buildFoundUI() : _buildNotFoundUI();
    }
  }

  Widget _buildFoundUI() {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Found")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: image != null && image!.isNotEmpty
                  ? Image.network(
                      image!,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 180),
                    )
                  : const Icon(Icons.image_not_supported, size: 180),
            ),
            const SizedBox(height: 20),
            Text(
              name ?? 'Unknown Product',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Barcode: $barcode",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Halal Status: ", style: TextStyle(fontSize: 18)),
                isHalal == true
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 28,
                      )
                    : const Icon(Icons.cancel, color: Colors.red, size: 28),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Get.offNamed("/scanner"),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text("Scan Another Product"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color.fromARGB(255, 11, 101, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFoundUI() {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Not Found")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            imagePath == null
                ? ElevatedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload Product Image"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color.fromARGB(255, 11, 101, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      imagePath = await UploadImg().pickImage();
                      setState(() {});
                    },
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imagePath!),
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 180),
                    ),
                  ),
            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: barcodeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Barcode",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<bool>(
              value: halal,
              decoration: InputDecoration(
                labelText: "Halal Status",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              items: const [
                DropdownMenuItem(value: true, child: Text("Halal")),
                DropdownMenuItem(value: false, child: Text("Non-Halal")),
              ],
              onChanged: (value) {
                setState(() {
                  halal = value ?? false;
                });
              },
            ),

            const SizedBox(height: 30),

            if (upLoading)
              const CircularProgressIndicator()
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Get.offNamed("/scanner"),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: const Color.fromARGB(255, 11, 101, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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
                      child: const Text("Upload"),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
