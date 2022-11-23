// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'planning_page.dart';
import 'Commander.dart';
import 'Dashbord.dart';
import 'panne_poubelle.dart';
import 'Parametre.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.num}) : super(key: key);
  int num;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  void initState() {
    index = widget.num;
    super.initState();
  }

  final screens = [
    const Dashbord(),
    const Planning(),
    const Commander(),
    const PannePoubelle(),
    const Parametre()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          if (mounted) {
             setState(() {
            index = i;
          });
          }
         
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "Dashbord",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range),
              label: "Planing",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: "Réclamtion",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Paramètres",
              backgroundColor: Colors.green),
        ],
      ),
    );
  }
}
