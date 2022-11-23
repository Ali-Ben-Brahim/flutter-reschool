import 'dart:convert';

import 'package:http/http.dart' as http;
import '../services/url_db.dart';

Future<Map<String, dynamic>> googleMapId(id) async {
 Map<String, dynamic> data = {};
  try{http.Response res = await http
      .get(Uri.parse('$regionmap/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[0]);
  }}catch(_){}
  return data;
}
Future<Map<String, dynamic>> plastique(id) async {
 Map<String, dynamic> data = {};
 try{
  http.Response res = await http
      .get(Uri.parse('$regionmap/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[1]);
  }
}catch(_){}
  
  return data;
}
Future<Map<String, dynamic>> papier(id) async {
 Map<String, dynamic> data = {};
 try{ http.Response res = await http
      .get(Uri.parse('$regionmap/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[2]);
  }}catch(_){}
  return data;
}
Future<Map<String, dynamic>> canette(id) async {
 Map<String, dynamic> data = {};
 try{ http.Response res = await http
      .get(Uri.parse('$regionmap/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[3]);
  }}catch(_){}
  return data;
}
Future<Map<String, dynamic>> composte(id) async {
 Map<String, dynamic> data = {};
 try{ http.Response res = await http
      .get(Uri.parse('$regionmap/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[4]);
  }}catch(_){}
  return data;
}
