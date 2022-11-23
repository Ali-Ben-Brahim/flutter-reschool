import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../gestionnaire/provider/login_provider.dart';
import '../constans.dart';
import '../provider/data_class.dart';


class Chart extends StatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
@override
  void initState() {
   final postModel1 = Provider.of<DataClass>(context, listen: false);
    postModel1.getPostData(Provider.of<LoginProvider>(context, listen: false).tokenuser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
       final postModel1 = Provider.of<DataClass>(context);
    return Center(
      child: postModel1.loading 
          ? const CircularProgressIndicator()
          : SizedBox(
              height: 200,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 70,
                      startDegreeOffset: -90,
                      sections: pieChart(),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: defaultPadding),
                        Text(
                          "${postModel1.post?.qteTotale!.toStringAsFixed(3)} KG",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w600,
                                  height: 0.5,
                                  fontSize: 20),
                        ),
                        const Text("Quantité Totale")
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  List<PieChartSectionData> pieChart() {
    List<PieChartSectionData> paiChartSelectionDatas = [
      PieChartSectionData(
        color: const Color.fromARGB(255, 67, 227, 22),
        value: Provider.of<DataClass>(context, listen: false).post?.sommeQteComposte ,
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: const Color(0xFF26E5FF),
        value: Provider.of<DataClass>(context, listen: false).post?.sommeQtePlastique ,
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: const Color(0xFFFFCF26),
        value: Provider.of<DataClass>(context, listen: false).post?.sommeQtePapier ,
        showTitle: false,
        radius: 19,
      ),
      PieChartSectionData(
        color: const Color(0xFFEE2727),
        value: Provider.of<DataClass>(context, listen: false).post?.sommeQteCanette ,
        showTitle: false,
        radius: 16,
      ),
    ];
    return paiChartSelectionDatas;
  }
}
