import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../services/dechets_service.dart';
import 'package:http/http.dart' as http;
extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
class DetailsHistorique extends StatefulWidget {
  int id_facture;
  String montant;
  DetailsHistorique({Key? key,required this.id_facture, required this.montant}) : super(key: key);

  @override
  State<DetailsHistorique> createState() => _DetailsHistoriqueState();
}

class _DetailsHistoriqueState extends State<DetailsHistorique> {
  List facture =[];
  final DechetService _dechetService = DechetService();
  String id_fact ="";
  String _montant =""; 
  @override
  void initState(){
    super.initState();
    _montant = widget.montant;
    id_fact =  widget.id_facture.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      getFacture();
    });
  }

  getFacture()async{
    try{
      http.Response res=await _dechetService.detailsFacture(Provider.of<AuthProvider>(context,listen: false).tokens, widget.id_facture.toString());
      if(res.statusCode==200){
        Map json = jsonDecode(res.body);
        setState(() {
          facture =json['data'];
        });
      }
    }catch(_){}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facture numéro $id_fact"),
          backgroundColor: const Color.fromRGBO(75, 174, 79,1),
          centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            child:facture.isEmpty? const CircularProgressIndicator():ListView.builder(
              itemCount: facture.length,
              itemBuilder: (context,index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${facture[index]['dechet']['type_dechet']}",
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 23),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${facture[index]['quantite'].toString()} x ${facture[index]['dechet']['prix_unitaire'].toString()} dt/kg",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Expanded(child:Container()),
                        Text(
                          "${(double.parse(facture[index]['quantite'].toString()) * double.parse(facture[index]['dechet']['prix_unitaire'].toString())).toPrecision(3)}",
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ],
                    ),
                      ],
                    ),
                  ),
                );
              },
            ), 
          ),
          Expanded(child: Container()),
          Container(
            height: 200,
            width: double.infinity,
            color: const Color.fromARGB(255, 16, 151, 20),
            child: Padding(
              padding:const EdgeInsets.symmetric( horizontal: 70 , vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                      Text(
                        "Total HT : ${(double.parse(_montant)*0.81).toPrecision(3)}",
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      Text(
                        "TVA 19 % : ${double.parse(_montant)*0.19}",
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      Text(
                        "Total TTC: $_montant",
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                        )
                    ]
              ), 
            ),
          ),
        ],
      )
    );
  }
}