import 'package:estionnaire/responsable_etablissment/provider/provider_model.dart';
import 'package:flutter/cupertino.dart';

import '../Model/data_model.dart';


class DataClass extends ChangeNotifier {
  
  DataModel? post;
  bool loading = false;
  
  getPostData(token) async {
    loading = true;try{

    post = (await getSinglePostData(token))!;}catch(e){
  print(e);
}
    loading = false;

    notifyListeners();
  }
}
