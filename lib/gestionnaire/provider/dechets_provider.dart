
// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

import '../services/dechets_services.dart';

class DechetsProvider extends ChangeNotifier{
  final DechetsServices _dechetsServices =DechetsServices();
  bool _isLoading=true;
  List _dechets =[];
  List _commandeDechets =[];
  List get commandeDechets=>_commandeDechets;
  List _detailsCommandeDechets =[];
  List get detailsCommandeDechets=>_detailsCommandeDechets;

  List get dechets=>_dechets;
  bool get isLoading =>_isLoading;

  loading(value){
    _isLoading=value;
    notifyListeners();
  }

  //--------------------------------------Dechets-------------------------------------------------------------------------
  allDechets()async{
    try{
      http.Response response = await _dechetsServices.allDechets();
      if(response.statusCode==200){
        dynamic data = jsonDecode(response.body);
        _dechets = data['data'];
        loading(false);
        notifyListeners();
      }
    }catch(_){}
  }

  updateDechets(id,data)async{
    try{
      loading(true);
      http.Response _res=await _dechetsServices.updateDechets(id,data);
      allDechets();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }

  ajouterDechets(data)async{
    try{
      loading(true);
      http.Response _res=await _dechetsServices.ajouterDechets(data);
      allDechets();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }  

  deleteDechets(id){
    try{
      _dechetsServices.deleteDechets(id);
      allDechets();
      notifyListeners();
    }catch(_){}
  }

  //--------------------------------------CommandeDechets-------------------------------------------------------------------------
  allCommandeDechets()async{
    try{
      http.Response response = await _dechetsServices.allCommandeDechets();
      if(response.statusCode==200){
        dynamic data = jsonDecode(response.body);
        _commandeDechets = data['data'];
        loading(false);
        notifyListeners();
      }
    }catch(_){}
  }

  updateCommandeDechets(id,data)async{
    try{
      loading(true);
      http.Response _res=await _dechetsServices.updateCommandeDechets(id,data);
      allCommandeDechets();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }

  ajouterCommandeDechets(data)async{
    try{
      loading(true);
      http.Response _res=await _dechetsServices.ajouterCommandeDechets(data);
      allCommandeDechets();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }  

  deleteCommandeDechets(id){
    try{
      _dechetsServices.deleteCommandeDechets(id);
      allCommandeDechets();
      notifyListeners();
    }catch(_){}
  }



  //--------------------------------------DetailsCommandeDechets-------------------------------------------------------------------------
  allDetailsCommandeDechets()async{
    try{
      http.Response response = await _dechetsServices.allDetailsCommandeDechets();
      if(response.statusCode==200){
        dynamic data = jsonDecode(response.body);
        _detailsCommandeDechets = data['data'];
        loading(false);
        notifyListeners();
      }
    }catch(_){}
  }

  updateDetailsCommandeDechets(id,data)async{
    try{
      loading(true);
      http.Response _res=await _dechetsServices.updateDetailsCommandeDechets(id,data);
      allDetailsCommandeDechets();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }

  ajouterDetailsCommandeDechets(data)async{
    try{
      loading(true);
      http.Response _res=await _dechetsServices.ajouterDetailsCommandeDechets(data);
      allDetailsCommandeDechets();
      loading(false);
      notifyListeners();
    }catch(_){
    }
  }  

  deleteDetailsCommandeDechets(id){
    try{
      _dechetsServices.deleteDetailsCommandeDechets(id);
      allDetailsCommandeDechets();
      notifyListeners();
    }catch(_){}
  }


}