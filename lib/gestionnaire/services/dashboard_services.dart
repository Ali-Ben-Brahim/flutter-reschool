import 'package:estionnaire/gestionnaire/services/base_url.dart';
import 'package:http/http.dart' as http;

class DashboardServices{



  getStatistiquesGenerales()async{
    try{
      http.Response response = await http.get(Uri.parse(statistiquesGeneralesURL));
      return response;
    }catch(_){}
  }



}