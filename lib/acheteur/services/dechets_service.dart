import 'dart:convert';

import '../services/url_db.dart';
import 'package:http/http.dart' as http;




class DechetService{

  Future getprix()async{
    try{
      return await http.get(Uri.parse(dechetsURL));
    }catch(_){}
  }

  Future commander(idClient, commandefinale, typePaiment, montantTotal, token) async{
    try{
       http.Response response= await http.post(
        Uri.parse(commanderURL),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
        },
        body: {
          'id_client' : idClient,
          'commande' : commandefinale,
          'type_paiment' : typePaiment,
          'montant_total' : montantTotal,
        });
        return response.statusCode;
    }catch(_){}
  }

  Future afficherFactureDechets(token)async{
    try{
      http.Response response= await http.post(
        Uri.parse(afficherDechetsClientURL),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
        },);
        return response;
    }catch(_){}
  }

  Future detailsFacture (token ,idFacture) async{
    try{
      http.Response response = await http.post(
        Uri.parse(afficherDetailsDechetURL),
        body: {
          "id" : idFacture
        },
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
        },
      );
      return response;  
    }catch(_){}
  }

}

Future alldechet() async{
  try{
    List<dynamic> list =[];
    Map data;

    try{
    http.Response response = await http.get(Uri.parse(dechetsURL));

    if(response.statusCode == 200){
        data = jsonDecode(response.body);
        list = data['data'];
    }
      }catch(_){}
    return list;

  }catch(_){}
}

