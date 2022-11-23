// ignore_for_file: unused_local_variable
import 'package:estionnaire/gestionnaire/services/base_url.dart';
import 'package:http/http.dart' as http;


class ResponsableEtablissmentServices{


  allResponsableEtablissment()async{
    try{
      http.Response response = await http.get(Uri.parse(responsableEtablissementURL));
      return response;
    }catch(_){}
  }

  updateResponsableEtablissment(id,data)async{
    try{
      http.Response response = await http.put(
        Uri.parse('$responsableEtablissementURL/$id'),
        body: data);
        return response;
    }catch(_){
    }
  }

  ajouterResponsableEtablissment(data)async{
    try{
      http.Response response = await http.post(
        Uri.parse(responsableEtablissementURL),
        body: data);
        return response;
    }catch(_){
    }
  }

  deleteResponsableEtablissment(id)async{
    try{
      await http.delete(Uri.parse('$responsableEtablissementURL/$id'));
    }catch(_){}
  }


}