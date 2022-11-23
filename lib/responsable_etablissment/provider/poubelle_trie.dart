import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Model/poubelle_trie_model.dart';
import '../services/url.dart';

Future<TrieModel?> getTrieData(token) async {
  TrieModel? result;

  try {
    final response = await http.get(
      Uri.parse(dashboard),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body)[2];
      print("item 2: $item");
      result = TrieModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
