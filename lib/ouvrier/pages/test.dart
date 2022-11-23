import 'package:estionnaire/provider/standard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../gestionnaire/provider/login_provider.dart';
import '../provider/table_class.dart';

class TestTable extends StatefulWidget {
  int id;
  TestTable({Key? key, required this.id}) : super(key: key);

  @override
  State<TestTable> createState() => _TestTableState();
}

class _TestTableState extends State<TestTable> {
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
    print(
        "id from table = ${Provider.of<StandarProvider>(context, listen: false).id}");
    super.initState();
  }

  DataRow getdata(dynamic data) {
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
            color: data['etat'] > 75
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

    return Scaffold(
      appBar: AppBar(),
      body: postModel.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    sortColumnIndex: sortColumnIndex,
                    sortAscending: isAscending,
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
                    rows: List.generate(postModel.post!.id!.length,
                        (index) => getdata(postModel.post!.id![index]))),
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
    final postModel = Provider.of<TableClass>(context, listen: false);
    if (columnIndex == 0) {
      postModel.post!.id!.sort((a, b) {
        return compareString(
            ascending, a["nom"].toString(), b["nom"].toString());
      });
    } else if (columnIndex == 1) {
      postModel.post!.id!.sort((a, b) {
        return compareString(
            ascending, a["type"].toString(), b["type"].toString());
      });
    } else if (columnIndex == 2) {
      postModel.post!.id!.sort((a, b) {
        return compareTo(ascending, a["etat"].toDouble(), b["etat"].toDouble());
      });
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
