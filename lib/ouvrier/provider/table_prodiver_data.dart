import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/table_model.dart';
import '../services/url_db.dart';

Future<TableModel?> getTableData(token, id) async {
  TableModel? result;

  try {
    final response = await http.get(
      Uri.parse("$poubellesTrie/$id"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      print("object ${item}");

      result = TableModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
