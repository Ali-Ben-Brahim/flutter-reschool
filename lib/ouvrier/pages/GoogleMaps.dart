import 'dart:async';
import 'dart:convert';
import 'package:estionnaire/ouvrier/composant/grid_box.dart';
import 'package:estionnaire/ouvrier/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;
import '../../gestionnaire/provider/login_provider.dart';
import '../provider/table_class.dart';
import '../services/bloc_etablissements_services.dart';
import '../services/function.dart';
import '../services/poubelle_service.dart';
import '../services/region-services.dart';
import '../services/url_db.dart';
import 'etablissement_api.dart';
import 'etat_poubelle.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  int id = 0;
  double distance = 0;
  bool visible = false;
  bool afficher = false;
  List<dynamic> etablissementData = [];
  List<dynamic> blocEtablissementsData = [];
  List<dynamic> etageEtablissementsData = [];
  List<dynamic> blocPoubelles = [];
  List<dynamic> poubelles = [];
  List<dynamic> blocEtablissements = [];
  List<dynamic> etageEtablissements = [];
  List<dynamic> poubelle = [];
  double moyenPlastique = 0.0;
  double moyenPapier = 0.0;
  double moyenCanette = 0.0;
  double moyenComposte = 0.0;
  int nbrPlastique = 0;
  int nbrPapier = 0;
  int nbrCanette = 0;
  int nbrComposte = 0;
  int nbrPlastique75 = 0;
  int nbrPapier75 = 0;
  int nbrCanette75 = 0;
  int nbrComposte75 = 0;
  int sommeEtab = 0;
  bool isEtablissement = true;
  bool isBlock = false;
  bool isEtaget = false;
  bool isPoubelle = false;
  bool isBlockPoubelle = false;
  Map<String, dynamic> data = {};
  Map<String, dynamic> dataPlastique = {};
  Map<String, dynamic> dataPapier = {};
  Map<String, dynamic> dataCanette = {};
  Map<String, dynamic> dataComposte = {};

  List listDistance = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  String url = '';
  late Timer timer;
  @override
  void initState() {
   
      getPostion();

      super.initState();

      distanceCalculate();
      getmarkers();
      etablissement(
          Provider.of<LoginProvider>(context, listen: false).tokenuser);
      timer = Timer.periodic(
          const Duration(seconds: 5),
          (Timer t) => etablissement(
              Provider.of<LoginProvider>(context, listen: false).tokenuser));
   
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<dynamic> dataetab = [];
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
            dataetab = datajson['etablissement'];
          });
        }

        print("data jason $dataetab");
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
    return dataetab;
  }

  dataplastiqueEtablissement(id) async {
    Map<String, dynamic> dataetab;
    try {
      dataetab = await plastique(id);
      if (mounted) {
        setState(() {
          dataPlastique = dataetab;
        });
      }
    } catch (_) {}
  }

  dataCanetteEtablissement(id) async {
    Map<String, dynamic> dataetab;
    try {
      dataetab = await canette(id);
      if (mounted) {
        setState(() {
          dataCanette = dataetab;
        });
      }
    } catch (_) {}
  }

  dataComposteEtablissement(id) async {
    Map<String, dynamic> dataetab;
    try {
      dataetab = await composte(id);
      if (mounted) {
        setState(() {
          dataComposte = dataetab;
        });
      }
    } catch (_) {}
  }

  dataPapierEtablissement(id) async {
    Map<String, dynamic> dataetab;
    try {
      dataetab = await papier(id);
      if (mounted) {
        setState(() {
          dataPapier = dataetab;
        });
      }
    } catch (_) {}
  }

  final Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<Position> positionStream;
  String googleAPiKey = "AIzaSyC0au9FbVLUYFvC5gRFnmXtiNYUgzM8Rwc";
  Set<Marker> markers = {};

  Check check = Check();
  late final CameraPosition _Myplace = const CameraPosition(
      target: LatLng(36.842597, 10.204778), zoom: 14.151926040649414);

  Future<void> goToplace(LatLng place) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: place, zoom: 17)));
  }

  distanceCalculate() {
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream().listen((Position? ps) {
      if (mounted) {
        setState(() {
          List.generate(dataetab.length, (index) {
            distance = Geolocator.distanceBetween(
                    ps == null ? 0.0 : ps.latitude,
                    ps == null ? 0.0 : ps.longitude,
                    dataetab[index]["latitude"],
                    dataetab[index]["longitude"]) /
                1000;

            listDistance[index] = distance;
          });
        });
      }
    });
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    if (mounted) {
      setState(() {
        for (int i = 0; i < dataetab.length; i++) {
          markers.add(
            Marker(
              onTap: () async {
                data = await googleMapId(dataetab[i]["id"]);
                dataplastiqueEtablissement(dataetab[i]["id"]);
                dataCanetteEtablissement(dataetab[i]["id"]);
                dataComposteEtablissement(dataetab[i]["id"]);
                dataPapierEtablissement(dataetab[i]["id"]);

                dataPapier = await papier(dataetab[i]["id"]);

                dataComposte = await composte(dataetab[i]["id"]);
                if (mounted) {
                  setState(() {
                    if (dataCanette.isNotEmpty &&
                        dataComposte.isNotEmpty &&
                        dataPapier.isNotEmpty &&
                        dataPlastique.isNotEmpty) {
                      nbrPlastique = dataPlastique['nombre_poubelle_plastique'];
                      nbrPapier = dataPapier['nombre_poubelle_papier'];
                      nbrCanette = dataCanette['nombre_poubelle_canette'];
                      nbrComposte = dataComposte['nombre_poubelle_composte'];
                      moyenPlastique =
                          dataPlastique['moyenne_pourcentage_plastique']
                              .toDouble();

                      nbrPlastique75 = dataPlastique[
                          'nbr_poubelle_plastique_rempli_plus_75'];
                      nbrPapier75 =
                          dataPapier['nbr_poubelle_papier_rempli_plus_75'];
                      nbrCanette75 =
                          dataCanette['nbr_poubelle_canette_rempli_plus_75'];
                      nbrComposte75 =
                          dataComposte['nbr_poubelle_composte_rempli_plus_75'];

                      moyenPapier =
                          dataPapier['moyenne_pourcentage_papier'].toDouble();
                      moyenCanette =
                          dataCanette['moyenne_pourcentage_canette'].toDouble();
                      moyenComposte =
                          dataComposte['moyenne_pourcentage_composte']
                              .toDouble();
                    }
                    if (data.isNotEmpty) {
                      blocEtablissementsData = data['bloc_etablissements'];
                    }
                    if (dataetab.isNotEmpty) {
                      title = dataetab[i]['nom_etablissement'];
                      url = dataetab[i]['url_map'];
                      id = dataetab[i]["id"];
                    }
                  });
                }
              },
              markerId: MarkerId(dataetab[i]['nom_etablissement'].toString()),
              position: LatLng(dataetab[i]['latitude'].toDouble(),
                  dataetab[i]['longitude'].toDouble()),
              infoWindow: InfoWindow(
                title: dataetab[i]['nom_etablissement'],
              ),
              icon: check
                  .check2(dataetab[i]['quantite_dechets_plastique'].toDouble()),
            ),
          );
        }
        print("active ${id}");
      });
    }

    return markers;
  }

  Future getPostion() async {
    bool services;
    LocationPermission per;
    try {
      services = await Geolocator.isLocationServiceEnabled();

      if (services == false) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Activer la localisation'),
                content: const Text(
                    "Pour continuer, activez la localisation de l'appareil, qui utlise le service de localisation de google"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () async {
                        await Geolocator.openLocationSettings();
                        Navigator.pop(context);
                      },
                      child: Text('Activer')),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); //close Dialog
                    },
                    child: Text('Annuler'),
                  )
                ],
              );
            });
      }
      per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission();
        if (per == LocationPermission.always) {}
      }
    } catch (_) {}
  }

  String title = "";
  @override
  Widget build(BuildContext context) {
    print("marker : $markers");
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: const Radius.circular(24.0),
      topRight: const Radius.circular(24.0),
    );
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.7;
    final halfw = MediaQuery.of(context).size.width;
    final halfh = MediaQuery.of(context).size.height * 0.7;

    return Scaffold(
        endDrawer: isBlock
            ? SafeArea(
                child: Drawer(
                    child: blocEtablissements.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (mounted) {
                                          setState(() {
                                            isEtablissement = false;
                                            isEtaget = true;
                                            isPoubelle = false;
                                            isBlock = false;
                                          });
                                        }
                                      },
                                      child: SizedBox(
                                          width: double.infinity,
                                          child: IconButton(
                                              onPressed: () {
                                                if (mounted) {
                                                  setState(() {
                                                    isBlock = false;
                                                    isEtablissement = true;
                                                    isEtaget = false;
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                Icons.arrow_back,
                                                size: 25,
                                              )))),
                                  const Text("Pas du bloc poubelle")
                                ]),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                    onTap: () {
                                      if (mounted) {
                                        setState(() {
                                          isEtablissement = false;
                                        });
                                      }
                                    },
                                    child: SizedBox(
                                        width: double.infinity,
                                        child: IconButton(
                                            onPressed: () {
                                              if (mounted) {
                                                setState(() {
                                                  isBlock = false;
                                                  isEtablissement = true;
                                                  isEtaget = false;
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.arrow_back,
                                              size: 25,
                                            )))),
                                SizedBox(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: blocEtablissements.length,
                                    itemBuilder: (context, i) {
                                      dynamic info = blocEtablissements[i];
                                      return InkWell(
                                        onTap: () {
                                          if (mounted) {
                                            setState(() {
                                              isEtaget = true;
                                              isBlock = false;
                                              isEtablissement = false;
                                              etageEtablissements =
                                                  blocEtablissements[i]
                                                      ["etage_etablissements"];
                                            });
                                          }
                                        },
                                        child: Card(
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      "${info['nom_bloc_etablissement']}"),
                                                  subtitle:
                                                      Text("${info['id']}"),
                                                ),
                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
              )
            : isEtablissement
                ? SafeArea(
                    child: Drawer(child: Etablidata()
                        //   ListView.builder(
                        //     itemCount: dataetab.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       dynamic infos = dataetab[index];
                        //       return ListTile(
                        //         title: Text("${infos['nom_etablissement']}"),
                        //         subtitle: Text(
                        //             "${listDistance[index].toStringAsFixed(2)} km"),
                        //         trailing: InkWell(
                        //           onTap: () async {
                        //             data = await googleMapId(infos['id']);
                        //             if (mounted) {
                        //               setState(() {
                        //                 isBlock = true;
                        //                 isEtablissement = false;
                        //                 isEtaget = false;

                        //                 blocEtablissements =
                        //                     data['bloc_etablissements'];
                        //               });
                        //             }
                        //           },
                        //           child:
                        //               Image.asset("assets/images/arrow-right.png"),
                        //         ),
                        //         onTap: () {
                        //           goToplace(LatLng(dataetab[index]["latitude"],
                        //               dataetab[index]["longitude"]));
                        //           Navigator.pop(context);
                        //         },
                        //       );
                        //     },
                        //   ),
                        // ),
                        ))
                : isBlockPoubelle
                    ? SafeArea(
                        child: Drawer(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 100,
                                    child: IconButton(
                                        onPressed: () {
                                          if (mounted) {
                                            setState(() {
                                              isBlock = false;
                                              isEtablissement = false;
                                              isEtaget = true;
                                              isBlockPoubelle = false;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          size: 25,
                                        ))),
                                SizedBox(
                                  height: halfh,
                                  child: ListView.builder(
                                    itemCount: blocPoubelles.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      dynamic infos = blocPoubelles[index];
                                      return InkWell(
                                        onTap: () async {
                                          if (mounted) {
                                            setState(() {
                                              isBlock = true;
                                              isEtablissement = false;
                                              isEtaget = false;
                                            });
                                          }
                                        },
                                        child: Card(
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      "${blocPoubelles[index]['id']}"),
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EtatPoubelle(
                                                                  id: blocPoubelles[
                                                                          index]
                                                                      ['id']))),
                                                ),
                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SafeArea(
                        child: Drawer(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 100,
                                    child: IconButton(
                                        onPressed: () {
                                          if (mounted) {
                                            setState(() {
                                              isBlock = true;
                                              isEtablissement = false;
                                              isEtaget = false;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          size: 25,
                                        ))),
                                SizedBox(
                                  height: halfh,
                                  child: ListView.builder(
                                    itemCount: etageEtablissements.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      dynamic infos =
                                          etageEtablissements[index];
                                      return InkWell(
                                        onTap: () {
                                          if (mounted) {
                                            setState(() {
                                              blocPoubelles =
                                                  etageEtablissements[index]
                                                      ["bloc_poubelles"];
                                              isBlock = false;
                                              isEtaget = false;
                                              isBlockPoubelle = true;
                                            });
                                          }
                                        },
                                        child: Card(
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      "${infos['nom_etage_etablissement']}"),
                                                  subtitle:
                                                      Text("${infos['id']}"),
                                                ),
                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF196f3d),
        ),
        body: _Myplace == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                SlidingUpPanel(
                  maxHeight: panelHeightOpen,
                  minHeight: panelHeightClosed,
                  renderPanelSheet: false,
                  borderRadius: radius,
                  collapsed: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () async {
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                icon: const Icon(
                                  Icons.directions,
                                  size: 50,
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  panel: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 253, 253, 253),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0)),
                    ),
                    child: SafeArea(child: LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.blue),
                                    ),
                                  ),
                                  Expanded(
                                      child: nbrCanette == 0 ||
                                              nbrPapier == 0 ||
                                              nbrComposte == 0 ||
                                              nbrPlastique == 0 ||
                                              moyenCanette == 0.0 ||
                                              moyenComposte == 0.0 ||
                                              moyenPapier == 0.0 ||
                                              moyenPlastique == 0.0
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : GridBox(
                                              nbrCanette75: nbrCanette75,
                                              nbrComposte75: nbrComposte75,
                                              nbrPapier75: nbrPapier75,
                                              nbrPlastique75: nbrPlastique75,
                                              id: id,
                                              nbrPapier: nbrPapier,
                                              nbrCanette: nbrCanette,
                                              nbrComposte: nbrComposte,
                                              nbrPlastique: nbrPlastique,
                                              moyenCanette: double.parse(
                                                  moyenCanette
                                                      .toStringAsFixed(2)),
                                              moyenComposte: double.parse(
                                                  moyenComposte
                                                      .toStringAsFixed(2)),
                                              moyenPapier: double.parse(
                                                  moyenPapier
                                                      .toStringAsFixed(2)),
                                              moyenPlastique: double.parse(
                                                  moyenPlastique
                                                      .toStringAsFixed(2)),
                                            )),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => TestTable(
                                                      id: id,
                                                    )),
                                          );
                                        },
                                        child: const Text("Voir tout")),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                  ),
                  body: GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: getmarkers(),
                    mapType: MapType.normal,
                    initialCameraPosition: _Myplace,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                )
              ]));
  }
}
//AIzaSyCM_y_hH1jw8ucuvhzfmGdKMloxPwBjbAo