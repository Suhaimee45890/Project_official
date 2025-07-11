import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MosqueNearbyLauncher extends StatefulWidget {
  const MosqueNearbyLauncher({super.key});

  @override
  State<MosqueNearbyLauncher> createState() => _MosqueNearbyLauncherState();
}

class _MosqueNearbyLauncherState extends State<MosqueNearbyLauncher> {
  final String _googleMapsUrl =
      "https://www.google.com/maps/search/มัสยิดใกล้ฉัน";

  Future<void> _launchMaps() async {
    final Uri url = Uri.parse(_googleMapsUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // 👈 opens in browser or app
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _launchMaps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Nearby Mosques'),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _launchMaps,
          icon: const Icon(Icons.location_on),
          label: const Text("Open Google Maps"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
