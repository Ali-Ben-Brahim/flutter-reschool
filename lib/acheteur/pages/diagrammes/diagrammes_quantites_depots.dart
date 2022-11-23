import 'dart:async';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart';
import 'package:estionnaire/acheteur/models/bar_model.dart';
import 'package:estionnaire/acheteur/models/gender_model.dart';
import 'package:estionnaire/acheteur/pages/model/collect_model.dart';
import 'package:estionnaire/acheteur/provider/collect_class.dart';
import 'package:estionnaire/acheteur/services/depot_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../../../gestionnaire/provider/login_provider.dart';

class DiagrammesQtDepot extends StatefulWidget {
  const DiagrammesQtDepot({Key? key}) : super(key: key);

  @override
  State<DiagrammesQtDepot> createState() => _DiagrammesQtDepotState();
}

class _DiagrammesQtDepotState extends State<DiagrammesQtDepot> {
  List<BarModel> genders = [];
  List<BarModel> getBarmodel() {
    return genders = [
      BarModel(
          name: 'Plastique',
          valeur: Provider.of<CollectClass>(context, listen: false)
              .post
              ?.quantiteTotalCollectePlastique ,
          color: Colors.blue),
      BarModel(
          name: 'Papier',
          valeur: Provider.of<CollectClass>(context, listen: false)
              .post
              ?.quantiteTotalCollectePapier,
          color: Colors.amber),
      BarModel(
          name: 'Composte',
          valeur: Provider.of<CollectClass>(context, listen: false)
              .post
              ?.quantiteTotalCollecteComposte,
          color: Colors.green),
      BarModel(
          name: 'Canette',
          valeur: Provider.of<CollectClass>(context, listen: false)
              .post
              ?.quantiteTotalCollecteCanette,
          color: Colors.red)
    ];
  }

  var _timer;
  @override
  void initState() {
    final postModel1 = Provider.of<CollectClass>(context, listen: false);
    postModel1.getCollectData(
            Provider.of<LoginProvider>(context, listen: false).tokenuser);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 30), (_) {
        postModel1.getCollectData(
            Provider.of<LoginProvider>(context, listen: false).tokenuser);
      });
    });
    super.initState();
  }

  List<charts.Series<BarModel, String>> _createSampleData() {
    return [
      charts.Series<BarModel, String>(
        data: getBarmodel(),
        id: 'quantites',
        domainFn: (BarModel genderModel, _) => genderModel.name,
        measureFn: (BarModel genderModel, _) => genderModel.valeur,
        colorFn: (BarModel genderModel, _) =>
            ColorUtil.fromDartColor(genderModel.color),
        labelAccessorFn: (BarModel genderModel, _) =>
            '${genderModel.valeur} Kg',
        outsideLabelStyleAccessorFn: (BarModel genderModel, _) =>
            const charts.TextStyleSpec(color: Color.black),
      )
    ];
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postModel1 = Provider.of<CollectClass>(context);
    return postModel1.loading
        ? SizedBox(
            height: 150,
            width: 150,
            child: Transform.scale(
                scale: 0.5, child: const CircularProgressIndicator()))
        : Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0),
            child: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: charts.BarChart(
                    _createSampleData(),
                    animate: true,
                    barRendererDecorator: charts.BarLabelDecorator<String>(),
                    domainAxis: const charts.OrdinalAxisSpec(),
                  ),
                ),
              ]),
            ),
          );
  }
}
