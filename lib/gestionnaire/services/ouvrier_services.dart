// ignore_for_file: unused_local_variable
import 'package:estionnaire/gestionnaire/services/base_url.dart';
import 'package:http/http.dart' as http;


class OurierServices{


  allOuvirer()async{
    try{
      http.Response response = await http.get(Uri.parse(ouvrierURL));
      return response;
    }catch(_){}
  }

  updateOuvrier(id,data)async{
    try{
      http.Response response = await http.put(
        Uri.parse('$ouvrierURL/$id'),
        body: data);
        return response;
    }catch(_){
    }
  }

  ajouterOuvrier(data)async{
    try{
      http.Response response = await http.post(
        Uri.parse(ouvrierURL),
        body: data);
        return response;
    }catch(_){
    }
  }

  deleteOuvrier(id)async{
    try{
      await http.delete(Uri.parse('$ouvrierURL/$id'));
    }catch(_){}
  }


}