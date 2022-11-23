import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/url_db.dart';
import 'package:http/http.dart' as http;


class DepotServices{


  Future getSomme(String token)async{
    try{
      http.Response response= await http.get(Uri.parse(sommeURL),
       headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
      });
      return response;     

    }catch(_){}
  }

}


  // Future getSomme()async{
  // try{
  //   http.Response response=await http.get(Uri.parse(sommeURL));
  //   return response;
  // }catch(_){}  
  // }

  Future  quantiteDepot() async{
    try{
    
      http.Response response = await http.get(Uri.parse(sommeURL));   
      if(response.statusCode==200){

        return jsonDecode(response.body);
      }
    }catch(_){}
  }


  Color couleur(e){
    if(e =='somme_depot_actuelle_plastique'){
      return Colors.blue;
      }else if(e == 'somme_depot_actuelle_composte'){
        return Colors.green;
      }else if(e=='somme_depot_actuelle_canette'){
        return Colors.red;
      } else{
        return Colors.amber;
      } 
  }
  String textPoubelle(e){
    if(e =="somme_depot_actuelle_plastique"){
      return "Plastique";
    }else if(e == "somme_depot_actuelle_papier"){
      return "Papier" ;
    }else if(e == "somme_depot_actuelle_composte"){
      return "Composte";
    }else{
      return "Canette";
    }
  }


