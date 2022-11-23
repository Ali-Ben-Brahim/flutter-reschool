import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/etablissement_model.dart';

import '../services/url_db.dart';

Future<EtabModel?> getEtabData(token) async {
  EtabModel? result;

  try {
    final response = await http.get(
      Uri.parse(regionmap),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      print("region map ${item}");

      result = EtabModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
