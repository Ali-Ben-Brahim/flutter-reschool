import 'package:flutter/cupertino.dart';
import 'dart:math';

import '../models/achat_model.dart';

class Cart with ChangeNotifier {

  final List _items=[];
  double _price = 0.0;
  int _quantitePlastique = 0 ;
  int _quantiteComposte = 0 ;
  int _quantitePapier = 0 ;
  int _quantiteCanette = 0 ;
  bool _commandeEffectuee = false;

  double get price =>roundDouble( _price , 3);
  int get nbre => _items.length;
  List get listeAchat => _items;
  int get quantitePlastique => _quantitePlastique;
  int get quantiteComposte => _quantiteComposte;
  int get quantitePapier => _quantitePapier;
  int get quantiteCanette => _quantiteCanette;
  bool get commandeEffectuee => _commandeEffectuee;

  double roundDouble(double value, int places){ 
    num mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }
  
  void addQuantitePlastique(){
    _quantitePlastique +=10;
    notifyListeners();
  }
  
  void addQuantiteComposte(){
    _quantiteComposte +=10;
    notifyListeners();
  }
  
  void addQuantitePapier(){
    _quantitePapier +=10;
    notifyListeners();
  }
  
  void addQuantiteCanette(){
    _quantiteCanette +=10;
    notifyListeners();
  }

 void setQuantitePlastique(int qte){
   _quantitePlastique =qte;
   notifyListeners();
 }
 
 void setQuantiteComposte(int qte){
   _quantiteComposte =qte;
   notifyListeners();
 }
 
 void setQuantitePapier(int qte){
   _quantitePapier =qte;
   notifyListeners();
 }
 
 void setQuantiteCanette(int qte){
   _quantiteCanette =qte;
   notifyListeners();
 }

  void removeQuantitePlastique(){
    _quantitePlastique -=10;
    notifyListeners();
  }
 
  void removeQuantiteComposte(){
    _quantiteComposte -=10;
    notifyListeners();
  }
 
  void removeQuantitePapier(){
    _quantitePapier +=10;
    notifyListeners();
  }
 
  void removeQuantiteCanette(){
    _quantiteCanette -=10;
    notifyListeners();
  }

void setCommandeEffectuee(){
  _commandeEffectuee = false;
  notifyListeners();
}

  void add(AchatModel item , quatitesCommander){
    int index =0;
    int i=0;
    bool isExist = false;
    if(_items.isNotEmpty){    

      while(i<_items.length){
          if(_items[i]['type']['id'] == item.id){
            index =i;
            isExist = true;
          }
          i++;
      }
      if(isExist){
        _items[index]['qte'] =quatitesCommander;
        double prixDechet = double.parse(item.prix_unitaire.toString()) * double.parse(quatitesCommander.toString());
        prixDechet = roundDouble(prixDechet, 3);
        double total = _items[index]['total'];
        _items[index]['total'] =prixDechet;
        _price -= total;
        _price += prixDechet;

      }else{
      double prixDechet = double.parse(item.prix_unitaire.toString()) * double.parse(quatitesCommander.toString());
      prixDechet = roundDouble(prixDechet, 3);
      _items.add({
        'type' : {
          'id': item.id,
          'type_dechet' : item.type_dechet,
          'prix_unitaire' : item.prix_unitaire,
        },
        'qte': quatitesCommander,
        'total' : prixDechet
      });
      _price += prixDechet;
      }

    }else{
      double prixDechet = double.parse(item.prix_unitaire.toString()) * double.parse(quatitesCommander.toString());
      prixDechet = roundDouble(prixDechet, 3);
      _items.add({
        'type' : {
          'id': item.id,
          'type_dechet' : item.type_dechet,
          'prix_unitaire' : item.prix_unitaire,
        },
        'qte': quatitesCommander,
        'total' : prixDechet});
      _price += prixDechet;
    }
    notifyListeners();
  }
  
  void remove(item){
    if(item['type']['type_dechet']=='plastique'){
      _quantitePlastique = 0;
    }
    if(item['type']['type_dechet']=='composte'){
      _quantiteComposte = 0;
    }
    if(item['type']['type_dechet']=='papier'){
      _quantitePapier = 0;
    }
    if(item['type']['type_dechet']=='canette'){
      _quantiteCanette = 0;
    }
    _items.remove(item);
    _price -= item['total'] ;
    if(_items.isEmpty){
      _price = 0;
    }
    notifyListeners();
  }

  void removeAll(){
    _commandeEffectuee = true;
    _items.clear();
    _price =0;
    _quantitePlastique = 0 ;
    _quantiteComposte = 0 ;
    _quantitePapier = 0 ;
    _quantiteCanette = 0 ;
    notifyListeners();
  }



}