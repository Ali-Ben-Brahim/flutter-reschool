import 'package:flutter/cupertino.dart';
import '../Model/poubelle_trie_model.dart';
import 'poubelle_trie.dart';


class TrieClass extends ChangeNotifier {
  
  TrieModel? post;
  bool loading = false;
  
  getPostData(token) async {
    loading = true;try{

    post = (await getTrieData(token))!;}
    catch(e){
  print(e);
}
    loading = false;

    notifyListeners();
  }
}
