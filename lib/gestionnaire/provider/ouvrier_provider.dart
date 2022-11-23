


// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../services/ouvrier_services.dart';


class OuvrierProvider extends ChangeNotifier{
  final OurierServices _ouvrierServices = OurierServices();
  bool _isloading =true;
  List _allOuvrier = [];
  bool get isloading => _isloading;
  List get ouvrier => _allOuvrier;

  loading(value){
    _isloading = value;
    notifyListeners();
  }
  allOuvrier()async{
    try{
      http.Response _res=await _ouvrierServices.allOuvirer();
      if(_res.statusCode ==200){
        dynamic _data = jsonDecode(_res.body);
        _allOuvrier = _data['data'];
        loading(false);
        notifyListeners();
      }
    }catch(_){}
  }
  
  updateOuvrier(id,data)async{
    try{
      loading(true);
      http.Response _res=await _ouvrierServices.updateOuvrier(id,data);
      allOuvrier();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }

  ajouterOuvrier(data)async{
    try{
      loading(true);
      http.Response _res=await _ouvrierServices.ajouterOuvrier(data);
      allOuvrier();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }  

  deleteOuvrier(id){
    try{
      _ouvrierServices.deleteOuvrier(id);
      allOuvrier();
      notifyListeners();
    }catch(_){}
  }
}