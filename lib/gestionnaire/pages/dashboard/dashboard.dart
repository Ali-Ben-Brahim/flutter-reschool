

import 'package:estionnaire/gestionnaire/pages/client/all_clients.dart';
import 'package:estionnaire/gestionnaire/pages/dechets/dechets.dart';
import 'package:flutter/material.dart';

import '../ouvrier/all_ouvrier.dart';
import '../reparateurs/mecanicien/all_mecanicien.dart';
import '../reparateurs/reparateur_poubelle/all_reparateur_poubelle.dart';
import '../responsable_etablissement/all_responsable_etablissements.dart';



class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AllClients(),
    AllOuvrier(),
    AllResponsablesEtablissment(),
    Mecanicien(),
    allRepateurPoubelle(),
    Dechets(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'clients',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'ouvriers',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'responsable etablissement',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'mecanicien',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'reparateur poubelle',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Dechets',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}



