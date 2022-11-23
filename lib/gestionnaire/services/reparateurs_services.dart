// ignore_for_file: unused_local_variable
import 'package:estionnaire/gestionnaire/services/base_url.dart';
import 'package:http/http.dart' as http;


class ReparateurServices{


  allRepateurPoubelle()async{
    try{
      http.Response response = await http.get(Uri.parse(reparateurPoubelleURL));
      return response;
    }catch(_){}
  }

  updateRepateurPoubelle(id,data)async{
    try{
      http.Response response = await http.put(
        Uri.parse('$reparateurPoubelleURL/$id'),
        body: data);
        return response;
    }catch(_){
    }
  }

  ajouterRepateurPoubelle(data)async{
    try{
      http.Response response = await http.post(
        Uri.parse(reparateurPoubelleURL),
        body: data);
        return response;
    }catch(_){
    }
  }

  deleteRepateurPoubelle(id)async{
    try{
      await http.delete(Uri.parse('$reparateurPoubelleURL/$id'));
    }catch(_){}
  }



  allMecanicien()async{
    try{
      http.Response response = await http.get(Uri.parse(mecanicienURL));
      return response;
    }catch(_){}
  }

  updateMecanicien(id,data)async{
    try{
      http.Response response = await http.put(
        Uri.parse('$mecanicienURL/$id'),
        body: data);
        return response;
    }catch(_){
    }
  }

  ajouterMecanicien(data)async{
    try{
      http.Response response = await http.post(
        Uri.parse(mecanicienURL),
        body: data);
        return response;
    }catch(_){
    }
  }

  deleteMecanicien(id)async{
    try{
      await http.delete(Uri.parse('$mecanicienURL/$id'));
    }catch(_){}
  }


}