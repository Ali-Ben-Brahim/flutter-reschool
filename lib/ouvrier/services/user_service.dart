import 'package:flutter/material.dart';
import 'dart:convert';
import '../pages/navbar.dart';
import '../services/url_db.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;


class Auth with ChangeNotifier {
  final bool _isLoggedIn = false;
  late User _user;
  late String _token;
  String get token => _token;
  bool get authenticated => _isLoggedIn;
  User get user => _user;

  Future<void> login(Map creeds, context) async{
    try {
      http.Response response = await http.post(
        Uri.parse(loginURL),
        body: creeds,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _user = User.fromJson(data['user']);
        _token = data['token'].toString();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Menu()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 250, 17, 0),
          content: Text('invalid champs'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error from server'),
      ));
    }
  }

  Future<void> loginqr(String valeur, context) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$loginQrURL/${valeur.trim()}'));
      if (valeur.isNotEmpty) {
        if (response.statusCode == 200) {
          _token ='';
          _user = User.fromJson(jsonDecode(response.body));
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Menu()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 250, 17, 0),
            content: Text('incorrect qr'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 250, 17, 0),
          content: Text('empty qr'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error from server'),
      ));
    }
  }

  Future logout() async{

    try{
      http.Response res = await http.post(Uri.parse(logoutURL ),
      headers: {
          'Authorization' : 'Bearer $_token',
          'Accept' : 'application/json'}
        );
    }catch(_){}

  }

  Future<void> update(Map creeds, context) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$updateUserURL/${_user.id}'),
          headers: {
            'Authorization' : 'Bearer $_token',
            'Accept' : 'application/json'
          },
          body: creeds);
      if (response.statusCode == 200) {
        var json =jsonDecode(response.body);
        _user = User.fromJson(json['ouvrier']);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 58, 250, 0),
          content: Text('data updated'),
        ));
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error server'),
      ));
    }
  }

  Future<void> updatePassword(creeds, context) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$updatePasswordURL/${_user.email}'),
          headers: {
            'Authorization' : 'Bearer $_token',
            'Accept' : 'application/json'
          },
          body: creeds);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 58, 250, 0),
          content: Text('Password updated'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error server'),
      ));
    }
  }

  Future supprimerImage()async{
    try{
       http.Response response =await http.post(Uri.parse(destroyImageURL),
          headers: {
            'Authorization' : 'Bearer $_token',
            'Accept' : 'application/json'
          },);
          if(response.statusCode==200){
            var json = jsonDecode(response.body);
            _user = User.fromJson(json['ouvrier']);
          }
    }catch(_){}
  }
  Future updateImage(image)async{
    try{


      // var request = http.MultipartRequest('POST', Uri.parse(updateImageURL))
      // ..fields.addAll(body)
      // ..headers.addAll(headers)
      // ..files.add(await http.MultipartFile.fromPath('image', filepath));


       http.Response response =await http.post(Uri.parse(updateImageURL),
          headers: {
            'Authorization' : 'Bearer $_token',
            'Accept' : 'application/json',
            'Content-Type': 'multipart/form-data',
          },
          body: {
            'photo' : image
          }
          );
          print("RESPONSE BODY : ${response.body}");
          // if(response.statusCode==200){
          //   var json = jsonDecode(response.body);
          //   _user = User.fromJson(json['ouvrier']);
          // }
    }catch(_){}
  }


}
