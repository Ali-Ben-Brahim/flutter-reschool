


// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../services/responsable_etablissement_servives.dart';



class ResponsableEtablissmentProvider extends ChangeNotifier{
  final ResponsableEtablissmentServices _responsable =ResponsableEtablissmentServices();
  bool _isloading =true;
  List _allresponsables = [];
  bool get isloading => _isloading;
  List get responsables => _allresponsables;

  loading(value){
    _isloading = value;
    notifyListeners();
  }
  
  allResponsables()async{
    try{
      http.Response _res=await _responsable.allResponsableEtablissment();
      if(_res.statusCode ==200){
        dynamic _data = jsonDecode(_res.body);
        _allresponsables = _data['data'];
        loading(false);
        notifyListeners();
      }
    }catch(_){}
  }
  
  updateResponsable(id,data)async{
    try{
      loading(true);
      http.Response _res=await _responsable.updateResponsableEtablissment(id,data);
      allResponsables();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }

  ajouterResponsable(data)async{
    try{
      loading(true);
      http.Response _res=await _responsable.ajouterResponsableEtablissment(data);
      allResponsables();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }  
  
  deleteResponsable(id){
    try{
      _responsable.deleteResponsableEtablissment(id);
      allResponsables();
      notifyListeners();
    }catch(_){}
  }
}