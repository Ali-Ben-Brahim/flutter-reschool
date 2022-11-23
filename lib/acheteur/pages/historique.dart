
import 'dart:async';
import 'dart:convert';
import 'package:estionnaire/acheteur/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../services/dechets_service.dart';
import 'details_historique.dart';

class Historique extends StatefulWidget {
  const Historique({ Key? key }) : super(key: key);

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  List history =[];
  final DechetService _dechetService = DechetService();
  var _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      _timer = Timer.periodic(const Duration(seconds: 3) , (Timer t) {
        getHistory();
      });    
    }
  }

  @override
  void dispose() {
    if(mounted){
    _timer.cancel();

    }
    super.dispose();   
  }


  getHistory()async{
    try{
      http.Response res=await _dechetService.afficherFactureDechets( Provider.of<AuthProvider>(context,listen: false).tokens);
      if(res.statusCode ==200){
        var json = jsonDecode(res.body);
        setState(() {
          history=json['data'];
        });
      }
    }catch(_){}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
        centerTitle: true,
        title: const Text("Historique",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
      ),
      body: history.isEmpty? Container() : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsHistorique(id_facture:history[index]['id'],montant : history[index]['montant_total'].toString())),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Facture numéro : ${history[index]['id']}",
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 23),
                    ),
                    Row(
                      children: [
                        Text(
                          "Date d'achat : ${history[index]['date_commande'].toString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Expanded(child:Container()),
                        const Text(
                          "voir les détails",
                          style: TextStyle(
                            color: Color.fromRGBO(31, 168, 227,1),
                            fontSize: 18 ),
                        ),
                      ],
                    ),
                    Text(
                      "Prix d'achat : ${history[index]['montant_total']} DT",
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 23),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}