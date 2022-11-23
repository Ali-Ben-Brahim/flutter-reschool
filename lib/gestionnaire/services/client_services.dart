// ignore_for_file: unused_local_variable
import 'package:estionnaire/gestionnaire/services/base_url.dart';
import 'package:http/http.dart' as http;


class ClientServices{


  allClient()async{
    try{
      http.Response response = await http.get(Uri.parse(clientURL));
      return response;
    }catch(_){}
  }

  updateClient(id,data)async{
    try{
      http.Response response = await http.put(
        Uri.parse('$clientURL/$id'),
        body: data);
        return response;
    }catch(_){
    }
  }

  ajouterClient(data)async{
    try{
      http.Response response = await http.post(
        Uri.parse(clientURL),
        body: data);
        return response;
    }catch(_){
    }
  }

  deleteClient(id)async{
    try{
      await http.delete(Uri.parse('$clientURL/$id'));
    }catch(_){}
  }


}