import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../gestionnaire/provider/login_provider.dart';
import '../services/function.dart';

import '../services/url_db.dart';
import '../services/user_service.dart';

class EtatCamion extends StatefulWidget {
  const EtatCamion({Key? key}) : super(key: key);

  @override
  State<EtatCamion> createState() => _EtatCamionState();
}

class _EtatCamionState extends State<EtatCamion> {
  Check check = Check();

  Map<String, dynamic> info = {};
  Future camionData() async {
    Map<String, dynamic> data = {};
    http.Response res = await http.get(Uri.parse(camion), headers: {
      'Authorization':
          'Bearer ${Provider.of<LoginProvider>(context, listen: false).tokenuser}',
      'Accept': 'application/json'
    });
    if (res.statusCode == 200) {
      data = jsonDecode(res.body)[1];
    }
    if (mounted) {
      setState(() {
        info = data;
      });
      return data;
    }
  }

  @override
  void initState() {
    camionData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF196f3d),
            title: const Text("Etat camion",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                ))),
        body: info['volume_maximale_camion'] == null
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: GridView.count(
                  primary: false,
                  childAspectRatio: (itemWidth / itemHeight),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Plastique"),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset("assets/images/camion.png"),
                          Container(
                            width: 80,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                )),
                            height: 80,
                            child: CircularPercentIndicator(
                              animation: true,
                              radius: 40,
                              lineWidth: 12,
                              percent: ((info["volume_actuelle_plastique"] /
                                  info['volume_maximale_camion'])),
                              progressColor: check.check(
                                  info["volume_actuelle_plastique"] /
                                      info['volume_maximale_camion']),
                              backgroundColor: Colors.grey,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                  "${(double.parse((info["volume_actuelle_plastique"] / info['volume_maximale_camion'] * 100).toString())).toStringAsFixed(3)} %"),
                            ),
                          ),
                        ]),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFc60001)),
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 40)),
                          ),
                          onPressed: () {},
                          child: const Text('Vider la poubelle'),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Papier"),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset("assets/images/camion.png"),
                          Container(
                            width: 80,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                )),
                            height: 80,
                            child: CircularPercentIndicator(
                              animation: true,
                              radius: 40,
                              lineWidth: 12,
                              percent: (info["volume_actuelle_papier"] /
                                  info['volume_maximale_camion']),
                              progressColor: check.check(
                                  info["volume_actuelle_papier"] /
                                      info['volume_maximale_camion']),
                              backgroundColor: Colors.grey,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                  "${(double.parse((info["volume_actuelle_papier"] / info['volume_maximale_camion'] * 100).toString())).toStringAsFixed(3)} %"),
                            ),
                          ),
                        ]),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFc60001)),
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 40)),
                          ),
                          onPressed: () {},
                          child: const Text('Vider la poubelle'),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Composte"),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset("assets/images/camion.png"),
                          Container(
                            width: 80,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                )),
                            height: 80,
                            child: CircularPercentIndicator(
                              animation: true,
                              radius: 40,
                              lineWidth: 12,
                              percent: (info["volume_actuelle_composte"] /
                                  info['volume_maximale_camion']),
                              progressColor: check.check(
                                  info["volume_actuelle_composte"] /
                                      info['volume_maximale_camion']),
                              backgroundColor: Colors.grey,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                  "${(double.parse((info["volume_actuelle_composte"] / info['volume_maximale_camion'] * 100).toString())).toStringAsFixed(3)} %"),
                            ),
                          ),
                        ]),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFc60001)),
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 40)),
                          ),
                          onPressed: () {},
                          child: const Text('Vider la poubelle'),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Canette"),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset("assets/images/camion.png"),
                          Container(
                            width: 80,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                )),
                            height: 80,
                            child: CircularPercentIndicator(
                              animation: true,
                              radius: 40,
                              lineWidth: 12,
                              percent: (info["volume_actuelle_canette"] /
                                  info['volume_maximale_camion']),
                              progressColor: check.check(
                                  info["volume_actuelle_canette"] /
                                      info['volume_maximale_camion']),
                              backgroundColor: Colors.grey,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                  "${(double.parse((info["volume_actuelle_canette"] / info['volume_maximale_camion'] * 100).toString())).toStringAsFixed(3)} %"),
                            ),
                          ),
                        ]),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFc60001)),
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 40)),
                          ),
                          onPressed: () {},
                          child: const Text('Vider la poubelle'),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }
}
