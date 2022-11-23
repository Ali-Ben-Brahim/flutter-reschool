import '../pages/commander.dart';
import '../pages/historique.dart';
import '../pages/parametre.dart';
import '../pages/service.dart';
import 'package:flutter/material.dart';

import 'diagrammes/page_diagrammes.dart';


class Accueil extends StatefulWidget {
  int? index;
  Accueil({ Key? key , this.index}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int selectedindex=0;
  @override
  void initState() {
    super.initState();
  selectedindex = widget.index??0;
  }
  List pages = const[
    PageDiagrammes(),
    Commander(),
    Service(),
    Historique(),
    Parametre(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedindex,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index){
          setState((){
            selectedindex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(label:"Statistique" ,icon: Icon(Icons.data_usage)),
          BottomNavigationBarItem(label:"Acheter" ,icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(label:"Réclamation" ,icon: Icon(Icons.support_agent)),
          BottomNavigationBarItem(label:"Historique" ,icon: Icon(Icons.history)),
          BottomNavigationBarItem(label:"Paramètres" ,icon: Icon(Icons.account_circle)),
        ],
      ),
      body : pages[selectedindex]
    );
  }
}