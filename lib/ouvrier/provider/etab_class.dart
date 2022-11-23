
import 'package:estionnaire/ouvrier/provider/etab_data.dart';
import 'package:flutter/cupertino.dart';
import '../models/etablissement_model.dart';

class EtabClass extends ChangeNotifier {
  
  EtabModel? post;
  bool loading = false;
  
  getPostData(token) async {
    loading = true;
    try{

    post = (await getEtabData(token))!;}
    catch(e){
  print(e);
}
    loading = false;

   notifyListeners();
  }
   
}
