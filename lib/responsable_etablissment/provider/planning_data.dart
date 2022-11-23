import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Model/planning_model.dart';
import '../services/url.dart';

Future<PlanningModel?> getPlannigData(token) async {
  PlanningModel? result;

  try {
    final response = await http.get(
      Uri.parse(planning),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      print("object ${item[0][0]}");

      result = PlanningModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
