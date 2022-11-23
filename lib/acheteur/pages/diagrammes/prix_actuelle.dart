import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../services/dechets_service.dart';
class PrixActuelle extends StatefulWidget {
  const PrixActuelle({ Key? key }) : super(key: key);

  @override
  State<PrixActuelle> createState() => _PrixActuelleState();
}

class _PrixActuelleState extends State<PrixActuelle> {
  List listPrix=[];
  var _timer;
  final DechetService _dechetService =DechetService();
  @override
  void initState() {
    if(mounted){
      _timer = Timer.periodic(const Duration(seconds: 1), (_){
        getprix();  
      });
    }
    super.initState();
  }

  getprix()async{
    try{
    http.Response response = await _dechetService.getprix();

      var data = jsonDecode(response.body);
      List info = data['data'];
      setState(() {
        listPrix=info;
      });
    }catch(_){}
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return listPrix.isEmpty? SizedBox(
      height: 150,
      width: 150,
      child: Transform.scale(
        scale: 0.5,
         child: const CircularProgressIndicator())
      ): MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2
      ),
      itemCount: listPrix.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text("${listPrix[index]['type_dechet']}"),),
              Center(child: Text("${listPrix[index]['prix_unitaire']}"),),
            ],)
        );
      }
    ),
  );
  }
}