import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Model/etablissement_model.dart';
import '../services/url.dart';

Future<EtablissementModel?> getData(token) async {
  EtablissementModel? result;

  try {
    final response = await http.get(
      Uri.parse(dashboard),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body)[0];
      print("item: $item");
      result = EtablissementModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
