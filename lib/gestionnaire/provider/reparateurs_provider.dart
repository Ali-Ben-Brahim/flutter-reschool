


// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../services/reparateurs_services.dart';



class ReparateursProvider extends ChangeNotifier{
  final ReparateurServices _reparateurServices = ReparateurServices();
  bool _isloading =true;
  List _allReparateurPoubelle = [];
  List _allMecanicien = [];
  bool get isloading => _isloading;
  List get reparateurPoubelle => _allReparateurPoubelle;
  List get mecanicien => _allMecanicien;

  loading(value){
    _isloading = value;
    notifyListeners();
  }
  allRepateurPoubelle()async{
    try{
      http.Response _res=await _reparateurServices.allRepateurPoubelle();
      if(_res.statusCode ==200){
        dynamic _data = jsonDecode(_res.body);
        _allReparateurPoubelle = _data['data'];
        loading(false);
        notifyListeners();
      }
    }catch(_){}
  }
  
  updateRepateurPoubelle(id,data)async{
    try{
      loading(true);
      http.Response _res=await _reparateurServices.updateRepateurPoubelle(id,data);
      allRepateurPoubelle();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }

  ajouterRepateurPoubelle(data)async{
    try{
      loading(true);
      http.Response _res=await _reparateurServices.ajouterRepateurPoubelle(data);
      allRepateurPoubelle();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }  

  deleteRepateurPoubelle(id){
    try{
      _reparateurServices.deleteRepateurPoubelle(id);
      allRepateurPoubelle();
      notifyListeners();
    }catch(_){}
  }







  allMecanicien()async{
    try{
      http.Response _res=await _reparateurServices.allMecanicien();
      if(_res.statusCode ==200){
        dynamic _data = jsonDecode(_res.body);
        _allMecanicien = _data['data'];
        loading(false);
        notifyListeners();
      }
    }catch(_){}
  }
  
  updateMecanicien(id,data)async{
    try{
      loading(true);
      http.Response _res=await _reparateurServices.updateMecanicien(id,data);
      allMecanicien();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }

  ajouterMecanicien(data)async{
    try{
      loading(true);
      http.Response _res=await _reparateurServices.ajouterMecanicien(data);
      allMecanicien();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }  

  deleteMecanicien(id){
    try{
      _reparateurServices.deleteMecanicien(id);
      allMecanicien();
      notifyListeners();
    }catch(_){}
  }

  
}