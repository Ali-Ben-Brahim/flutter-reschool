import 'package:estionnaire/ouvrier/services/url_db.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:developer';

import '../../gestionnaire/provider/login_provider.dart';

class Etablidata extends StatefulWidget {
  Etablidata({Key? key}) : super(key: key);

  @override
  State<Etablidata> createState() => _EtablidataState();
}

class _EtablidataState extends State<Etablidata> {
  List<dynamic> data = [];
  List<dynamic> poubelle = [];
  List<dynamic> trie = [];
  Future<List<dynamic>> etablissement(token) async {
    try {
      final response = await http.get(
        Uri.parse(map),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Charset': 'utf-8'
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> datajson = json.decode(response.body);
        if (mounted) {
          setState(() {
            data = datajson['etablissement'];
          });
        }
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  void initState() {
    if (mounted) {
      etablissement(
          Provider.of<LoginProvider>(context, listen: false).tokenuser);
    }

    super.initState();
  }

  List etab = [];

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {}
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(data.length, (int index) {
            // poubelle = data[index]["poubelles"];

            poubelle.addAll(data[index]["poubelles"]);
            trie = poubelle.map(
              (e) {
                if (e["Etat"] >= 75) {
                  return e;
                }
              },
            ).toList();

            print(" taille : ${trie.length}");
            trie.removeWhere((element) => element == null);
            trie.sort((a, b) {
              return b['Etat'].toDouble().compareTo(a['Etat'].toDouble());
            });
            return Column(
              children: List.generate(trie.length, (i) {
                poubelle.clear();

                return ListTile(
                    leading: const Icon(Icons.location_on),
                    subtitle: Text("${trie[i]["nom"]}"),
                    trailing: Text(
                      "${trie[i]["Etat"]} %",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    title: Text("${trie[i]["type"]}"));
              }),
            );
          }),
        ),
      ),
    );
  }
}
