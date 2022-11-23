// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import '../constans.dart';
import 'package:http/http.dart' as http;

import '../services/url.dart';
import 'dart:convert';

class Dashboard2 extends StatefulWidget {
  const Dashboard2({Key? key}) : super(key: key);

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  String token = "1|Hbym1aZXorJ0S9l8ho7vH9jIW2C53ugGWHlr45dB";
  Map data = {};
  List poubelles = [];
  int? sortColumnIndex;
  bool isAscending = false;
  @override
  void initState() {
    afficherDashboard(token);
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
      dataList = jsonDecode(response.body)[0];
      setState(() {
        data = dataList;
        poubelles = data["poubelles"];
      });

      return dataList;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tout les poubelles",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: SingleChildScrollView(
              child: DataTable(
                columnSpacing: defaultPadding,
                sortColumnIndex: sortColumnIndex,
                sortAscending: isAscending,
                columns: [
                  DataColumn(
                    label: const Text("Nom"),
                    onSort: onSort,
                  ),
                  DataColumn(
                    label: const Text("Type"),
                    onSort: onSort,
                  ),
                  DataColumn(
                    label: const Text("État"),
                    onSort: onSort,
                  ),
                ],
                rows: List.generate(
                  poubelles.length,
                  (index) => recentFileDataRow(poubelles[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      poubelles.sort((a, b) {
        return compareString(
            ascending, a["nom"].toString(), b["nom"].toString());
      });
    } else if (columnIndex == 1) {
      poubelles.sort((a, b) {
        return compareString(
            ascending, a["type"].toString(), b["type"].toString());
      });
    } else if (columnIndex == 2) {
      poubelles.sort((a, b) {
        return compareString(
            ascending, a["Etat"].toString(), b["Etat"].toString());
      });
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascendig, String value1, String value2) {
    return ascendig ? value1.compareTo(value2) : value2.compareTo(value1);
  }
}

DataRow recentFileDataRow(dynamic poubelles) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.asset(
              "assets/images/${poubelles["type"]}.png",
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                poubelles["nom"],
                style: const TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(poubelles["type"])),
      DataCell(Text("${poubelles["Etat"]} %")),
    ],
  );
}
