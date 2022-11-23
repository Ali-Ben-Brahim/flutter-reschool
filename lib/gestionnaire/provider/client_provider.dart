


// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:estionnaire/gestionnaire/services/client_services.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';



class ClientProvider extends ChangeNotifier{
  final ClientServices _client =ClientServices();
  bool _isloading =true;
  List _allclients = [];
  bool get isloading => _isloading;
  List get clients => _allclients;

  loading(value){
    _isloading = value;
    notifyListeners();
  }
  
  allClient()async{
    try{
      http.Response _res=await _client.allClient();
      if(_res.statusCode ==200){
        dynamic _data = jsonDecode(_res.body);
        _allclients = _data['data'];
        loading(false);
        notifyListeners();
      }
    }catch(_){}
  }
  
  updateClient(id,data)async{
    try{
      loading(true);
      http.Response _res=await _client.updateClient(id,data);
      allClient();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }
  
  ajouterClient(data)async{
    try{
      loading(true);
      http.Response _res=await _client.ajouterClient(data);
      allClient();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  } 

  deleteClient(id){
    try{
      _client.deleteClient(id);
      allClient();
      notifyListeners();
    }catch(_){}
  }
}