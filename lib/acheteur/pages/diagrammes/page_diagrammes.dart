

import 'package:estionnaire/acheteur/pages/diagrammes/prix_actuelle.dart';
import 'package:flutter/material.dart';

import 'diagrammes_quantites_depots.dart';

class PageDiagrammes extends StatefulWidget {
  const PageDiagrammes({ Key? key }) : super(key: key);

  @override
  State<PageDiagrammes> createState() => _PageDiagrammesState();
}

class _PageDiagrammesState extends State<PageDiagrammes> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Statistique",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
      ),
      body: Card(
        child: ListView(
          children:const[
            Center(child: Text("La quantite disponible dans nos depots", style:TextStyle(fontSize: 18.0 , fontWeight: FontWeight.bold))),
            DiagrammesQtDepot(),
            Divider(
              thickness: 2,
              color: Color.fromRGBO(98, 98, 98,1),
            ),
            Center(child: Text("Prix actuelle", style:TextStyle(fontSize: 18.0 , fontWeight: FontWeight.bold))),
            PrixActuelle(),
            Divider(
              thickness: 2,
              color: Color.fromRGBO(98, 98, 98,1),
            ),
            Center(child: Text(" Quantités achetées ", style:TextStyle(fontSize: 18.0 , fontWeight: FontWeight.bold))),
              
          ]
          ),
      ),
    );
  }
}