import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Model/data_model.dart';
import '../services/url.dart';



Future<DataModel?> getSinglePostData(token) async {
  DataModel? result;
 

  try {
    final response = await http.get(
      Uri.parse(dashboard),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body)[1];
      result = DataModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
