import 'package:estionnaire/gestionnaire/services/base_url.dart';
import 'package:http/http.dart' as http;

class DechetsServices{
  //--------------------------------------Dechets-------------------------------------------------------------------------
  allDechets()async{
    try{
      http.Response response = await http.get(Uri.parse(dechetsURL));
      return response;
    }catch(_){}
  }
  
  updateDechets(id,data)async{
    try{
      http.Response response = await http.put(
        Uri.parse('$dechetsURL/$id'),
        body: data);
        return response;
    }catch(_){
    }
  }

  ajouterDechets(data)async{
    try{
      http.Response response = await http.post(
        Uri.parse(dechetsURL),
        body: data);
        return response;
    }catch(_){
    }
  }

  deleteDechets(id)async{
    try{
      await http.delete(Uri.parse('$dechetsURL/$id'));
    }catch(_){}
  }

  //--------------------------------------CommandeDechets-------------------------------------------------------------------------
  allCommandeDechets()async{
    try{
      http.Response response = await http.get(Uri.parse(commandeDechetURL));
      return response;
    }catch(_){}
  }
  
  updateCommandeDechets(id,data)async{
    try{
      http.Response response = await http.put(
        Uri.parse('$commandeDechetURL/$id'),
        body: data);
        return response;
    }catch(_){
    }
  }

  ajouterCommandeDechets(data)async{
    try{
      http.Response response = await http.post(
        Uri.parse(commandeDechetURL),
        body: data);
        return response;
    }catch(_){
    }
  }

  deleteCommandeDechets(id)async{
    try{
      await http.delete(Uri.parse('$commandeDechetURL/$id'));
    }catch(_){}
  }


  //--------------------------------------DetailsCommandeDechets-------------------------------------------------------------------------
  allDetailsCommandeDechets()async{
    try{
      http.Response response = await http.get(Uri.parse(detailCommandeDechetsURL));
      return response;
    }catch(_){}
  }
  
  updateDetailsCommandeDechets(id,data)async{
    try{
      http.Response response = await http.put(
        Uri.parse('$detailCommandeDechetsURL/$id'),
        body: data);
        return response;
    }catch(_){
    }
  }

  ajouterDetailsCommandeDechets(data)async{
    try{
      http.Response response = await http.post(
        Uri.parse(detailCommandeDechetsURL),
        body: data);
        return response;
    }catch(_){
    }
  }

  deleteDetailsCommandeDechets(id)async{
    try{
      http.Response res = await http.delete(Uri.parse('$detailCommandeDechetsURL/$id'));
      print(res.body);
    }catch(_){}
  }

}