// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../gestionnaire/provider/login_provider.dart';
import '../Data/info.dart';

import '../constans.dart';
import '../services/function.dart';
import '../services/url.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  List type = [{"type":"plastique"},
  {"type":"canette"},
  {"type":"papier"},
  {"type":"composte"},];
  Map data = {};
  Map nombreP = {};
  @override
  void initState() {
    afficherDashboard(Provider.of<LoginProvider>(context, listen: false).tokenuser);
    nombre(Provider.of<LoginProvider>(context, listen: false).tokenuser);
    super.initState();
  }

  Future afficherDashboard(token) async {
    Map dataList = {};
    try {
      http.Response response = await http.get(
        Uri.parse(dashboard),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      dataList = jsonDecode(response.body)[1];
      setState(() {
        data = dataList;
      });

      return dataList;
    } catch (_) {}
  }

  Future nombre(token) async {
    Map dataList = {};
    try {
      http.Response response = await http.get(
        Uri.parse(dashboard),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      dataList = jsonDecode(response.body)[0];
      setState(() {
        nombreP = dataList;
      });

      return dataList;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty || nombreP.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: type.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(defaultPadding),
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Image.asset(
                                    "assets/images/${type[index]['type']}.png",
                                  ),
                                ),
                                Text("(${nombreP['poubelle_${type[index]['type']}']} P)")
                              ],
                            ),
                             Text("${type[index]['type']}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 16)),
                            ProgressLine(
                              color: check(
                                  data["pourcentage_qt_poubelle_${type[index]['type']}"]),
                              percentage:
                                  data["pourcentage_qt_poubelle_${type[index]['type']}"],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${data["somme_qt_dechet_${type[index]['type']}"]} Kg",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color:
                                              const Color.fromARGB(179, 86, 86, 86)),
                                ),
                                Text(
                                  "${data["pourcentage_qt_poubelle_${type[index]['type']}"]} %",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color:
                                              const Color.fromARGB(179, 86, 86, 86)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
