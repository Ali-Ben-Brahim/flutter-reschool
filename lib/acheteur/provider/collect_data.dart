import 'dart:convert';
import 'dart:developer';
import 'package:estionnaire/acheteur/pages/model/collect_model.dart';
import 'package:estionnaire/acheteur/services/url_db.dart';
import 'package:http/http.dart' as http;


Future<CollectModel?> getSommeData(token) async {
  CollectModel? result;

  try {
    final response = await http.get(
      Uri.parse(sommeURL),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      print("item 2: $item");
      result = CollectModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
