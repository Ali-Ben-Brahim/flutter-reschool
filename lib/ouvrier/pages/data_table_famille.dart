import 'package:estionnaire/provider/standard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../gestionnaire/provider/login_provider.dart';
import '../provider/table_class.dart';

class DataFamille extends StatefulWidget {
  int id;
  String type;
  DataFamille({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  State<DataFamille> createState() => _DataFamilleState();
}

class _DataFamilleState extends State<DataFamille> {
  int? sortColumnIndex;
  bool isAscending = false;
  List? blocE;
  List? etage;
  @override
  void initState() {
    final postModel = Provider.of<TableClass>(context, listen: false);
    postModel.getPostData(
        Provider.of<LoginProvider>(context, listen: false).tokenuser,
        widget.id);
 

    print("id from table = ${widget.id}");
    super.initState();
  }

  List selectedtype = [];

  DataRow getdata(Map data) {
    return DataRow(cells: [
      DataCell(Text(
        "${data['nom']}",
        style: const TextStyle(fontSize: 12),
      )),
      DataCell(Text("${data['type']}")),
      DataCell(Text(
        "${data['etat']} %",
        maxLines: 1,
        style: TextStyle(
            color: data['etat'] >= 75
                ? Colors.red
                : data['etat'] > 25
                    ? Colors.amber
                    : Colors.green),
      )),
    ]);
  }



  @override
  Widget build(BuildContext context) {
     final postModel = Provider.of<TableClass>(context, listen: true);
    if (postModel.loading == false) {
      selectedtype = postModel.post!.id!.map((type) {
        if (type["type"] == widget.type) return type;
      }).toList();
      selectedtype.removeWhere((element) {
        return element.toString().contains("null");
      });
    }
    print("selectedtype : $selectedtype");
    return Scaffold(
      appBar: AppBar(),
      body: selectedtype.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    // Datatable widget that have the property columns and rows.
                    columns: [
                      DataColumn(
                        label: const Text('Nom'),
                        onSort: onSort,
                      ),
                      DataColumn(
                        label: const Text('type'),
                        onSort: onSort,
                      ),
                      DataColumn(
                        label: const Text('etat'),
                        onSort: onSort,
                      ),
                    ],
                    rows: List.generate(selectedtype.length,
                        (index) => getdata(selectedtype[index]))),
              ),
            ),
    );
  }

  int compareString(bool ascendig, String value1, String value2) {
    return ascendig ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  int compareTo(bool ascendig, double value1, double value2) {
    return ascendig ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      selectedtype.sort((a, b) {
        return compareString(
            ascending, a["nom"].toString(), b["nom"].toString());
      });
    } else if (columnIndex == 1) {
      selectedtype.sort((a, b) {
        return compareString(
            ascending, a["type"].toString(), b["type"].toString());
      });
    } else if (columnIndex == 2) {
      selectedtype.sort((a, b) {
        return compareTo(ascending, a["etat"].toDouble(), b["etat"].toDouble());
      });
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
