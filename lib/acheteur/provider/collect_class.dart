import 'package:estionnaire/acheteur/provider/collect_data.dart';
import 'package:flutter/cupertino.dart';

import '../pages/model/collect_model.dart';




class CollectClass extends ChangeNotifier {
  CollectModel? post;
  bool loading = false;

  getCollectData(token) async {
    loading = true;
    try {
      post = (await getSommeData(token))!;
      print("nom ${post!.quantiteTotalCollecteCanette}");
    } catch (e) {
      print(e);
    }
    loading = false;

    notifyListeners();
  }
}
