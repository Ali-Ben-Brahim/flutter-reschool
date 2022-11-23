import 'package:flutter/material.dart';
import '../pages/GoogleMaps.dart';
import '../pages/etatcamion.dart';
import '../pages/reclamation.dart';
import '../pages/setting.dart';
import '../pages/scanPoubelle.dart';
import '../pages/zoneDeDepot.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int currentIndex = 1;
  List pages = [
    const MapSample(),
    const EtatCamion(),
    const ZoneDepot(),
    const Signaler(),
    const MyHomePage(),
    const Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,

        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          if (mounted) currentIndex = index;
        }), //bottom navigation bar on scaffold
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "état poubelle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: "état camion",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: "Zone de dépôt",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem),
            label: "Réclamtion",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: "Scan Poubelle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
