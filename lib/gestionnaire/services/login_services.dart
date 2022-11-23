import 'package:http/http.dart' as http;

import 'base_url.dart';

class LoginServices{

  login(data)async{
    try{
      http.Response response = await http.post(Uri.parse(loginURL),body: data);
      print("code ${response.statusCode}");
      return response;
    }catch(_){}
  }
}