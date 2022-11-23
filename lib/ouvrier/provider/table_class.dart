
import 'package:flutter/cupertino.dart';

import '../models/table_model.dart';
import 'table_prodiver_data.dart';

class TableClass extends ChangeNotifier {
  
  TableModel? post;
  bool loading = false;
  
  getPostData(token,id) async {
    loading = true;
    try{

    post = (await getTableData(token, id))!;}
    catch(e){
  print(e);
}
    loading = false;

   notifyListeners();
  }
   
}
