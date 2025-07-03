import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AfterScan extends StatefulWidget {
  const AfterScan({super.key});

  @override
  State<AfterScan> createState() => _AfterScanState();
}

class _AfterScanState extends State<AfterScan> {
  final String barcode = Get.arguments;
  bool isLoading = true;
  String? image;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product found")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Image.network(
                image!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
      ),
    );
  }
}
