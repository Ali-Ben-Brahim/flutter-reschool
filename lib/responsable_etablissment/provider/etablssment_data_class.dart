import 'package:flutter/cupertino.dart';


import '../Model/etablissement_model.dart';
import 'dashboard_etablissement.dart';

class EtablissementDataClass extends ChangeNotifier {
  EtablissementModel? post;
  bool loading = false;

  getEtablissmentdata(token) async {
    loading = true;
    try {
      post = (await getData(token))!;
      print("nom ${post!.nomEtablissement}");
    } catch (e) {
      print(e);
    }
    loading = false;

    notifyListeners();
  }
}
