import 'package:estionnaire/responsable_etablissment/provider/planning_data.dart';
import 'package:estionnaire/responsable_etablissment/provider/provider_model.dart';
import 'package:flutter/cupertino.dart';

import '../Model/data_model.dart';
import '../Model/planning_model.dart';


class PlanningClass extends ChangeNotifier {
  
  PlanningModel? post;
  bool loading = false;
  
  getPostData(token) async {
    loading = true;
    try{

    post = (await getPlannigData(token))!;}
    catch(e){
  print(e);
}
    loading = false;

   notifyListeners();
  }
   
}
