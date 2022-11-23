import 'dart:convert';
import 'dart:developer';

import 'package:estionnaire/responsable_etablissment/pages/acceuil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../acheteur/pages/accueil.dart';
import '../../ouvrier/pages/data_etab.dart';
import '../../ouvrier/pages/etablissement_api.dart';
import '../../ouvrier/pages/navbar.dart';
import '../../ouvrier/pages/test.dart';
import '../../ouvrier/services/url_db.dart';
import '../../responsable_etablissment/pages/try.dart';
import '../services/login_services.dart';

class LoginProvider extends ChangeNotifier {
  final LoginServices _login = LoginServices();
  dynamic tokenuser;
  dynamic userid;
  dynamic nom;
  dynamic prenon;
  dynamic cin;
  dynamic email;
  dynamic photo;
  dynamic tel;
  dynamic user;
  Future<void> update(Map creeds, context) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$updateUserURL/${userid}'),
          headers: {
            'Authorization': 'Bearer $tokenuser',
            'Accept': 'application/json'
          },
          body: creeds);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        // _user = User.fromJson(json['ouvrier']);
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
      http.Response response = await http.post(
          Uri.parse('$updatePasswordURL/$email'),
          headers: {
            'Authorization': 'Bearer $tokenuser',
            'Accept': 'application/json'
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

  Future logout() async {
    try {
      http.Response res = await http.post(Uri.parse(logoutURL), headers: {
        'Authorization': 'Bearer $tokenuser',
        'Accept': 'application/json'
      });
    } catch (_) {}
  }

  login(data, context) async {
    try {
      http.Response res = await _login.login(data);

      if (res.statusCode == 200) {
        dynamic data = jsonDecode(res.body);
        dynamic role = data['Role'];
        tokenuser = data['token'];

        print(role);
        print(tokenuser);
        print(userid);
        print(data['status']);
          if (data['status'] == 401) {
            Fluttertoast.showToast(
                msg:
                    "votre mot de passe est incorrect",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          else if(data['status'] == 200){
            Fluttertoast.showToast(
                msg:
                    "Login success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        if (role == 'gestionnaire') {}
        if (role == 'responsable_etablissement') {
        
          print(tokenuser);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AcceuilResponsableEtablissement()),
          );
        }
        if (role == 'client_dechet') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Accueil()),
          );
        }
        if (role == 'ouvrier') {
          user = data['user'];
          userid = data['user']['id'];
          cin = data['user']['CIN'];
          email = data['user']['email'];
          nom = data['user']['nom'];
          prenon = data['user']['prenom'];
          tel = data['user']['numero_telephone'];
          photo = data['user']['photo'];

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Menu()));
        }
        if (role == 'responsable_personnel') {}
        if (role == 'responsable_commerciale') {}
      } else if (res.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "check internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (res.statusCode == 403) {
        Fluttertoast.showToast(
            msg: "Mot de passe incorrect",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future supprimerImage() async {
    try {
      http.Response response = await http.post(
        Uri.parse(destroyImageURL),
        headers: {
          'Authorization': 'Bearer $tokenuser',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        // _user = User.fromJson(json['ouvrier']);
      }
    } catch (_) {}
  }

  Future updateImage(image) async {
    try {
      // var request = http.MultipartRequest('POST', Uri.parse(updateImageURL))
      // ..fields.addAll(body)
      // ..headers.addAll(headers)
      // ..files.add(await http.MultipartFile.fromPath('image', filepath));

      http.Response response =
          await http.post(Uri.parse(updateImageURL), headers: {
        'Authorization': 'Bearer $tokenuser',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      }, body: {
        'photo': image
      });
      print("RESPONSE BODY : ${response.body}");
      // if(response.statusCode==200){
      //   var json = jsonDecode(response.body);
      //   _user = User.fromJson(json['ouvrier']);
      // }
    } catch (_) {}
  }
}
