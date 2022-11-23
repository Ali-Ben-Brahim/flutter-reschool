import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:estionnaire/ouvrier/services/url_db.dart';

import '../../gestionnaire/provider/login_provider.dart';

class ZoneDepot extends StatefulWidget {
  const ZoneDepot({Key? key}) : super(key: key);

  @override
  State<ZoneDepot> createState() => _ZoneDepotState();
}

class _ZoneDepotState extends State<ZoneDepot> {
  Map<String, dynamic> data = {};
  List<dynamic> poubelle = [];
  double lat = 10;
  double long = 20;
  List<dynamic> trie = [];
  Future<Map<String, dynamic>> etablissement(token) async {
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
        final datajson = json.decode(response.body);
        if (mounted) {
          setState(() {
            data = datajson['zone_depot'];
            lat = data['latitude'].toDouble();
            long = data['longitude'].toDouble();
            print("list data: ${data['adresse']}");
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

  LatLng bebLassal = const LatLng(36.813464052870216, 10.1689277263485);

  Set<Marker> markers = {};
  String googleAPiKey = "AIzaSyC0au9FbVLUYFvC5gRFnmXtiNYUgzM8Rwc";
  @override
  Widget build(BuildContext context) {
    CameraPosition BebLassal =
        CameraPosition(target: LatLng(lat, long), zoom: 14.151926040649414);
    markers.add(
      Marker(
        markerId: const MarkerId("Zone1"),
        position: bebLassal, //position of marker
        infoWindow: InfoWindow(title: "${data["adresse"]}"),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    final Completer<GoogleMapController> _controller = Completer();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF196f3d),
            title: const Text("Zone de depot",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                ))),
        body: data.isEmpty || lat == 10 || long == 20
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                Container(
                  width: 500,
                  height: 400,
                  padding: const EdgeInsets.all(20),
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: markers,
                    mapType: MapType.normal,
                    initialCameraPosition: BebLassal,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                ListTile(
                    title: Text("${data['adresse']}"),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.directions,
                        color: Colors.blue,
                        size: 38,
                      ),
                      onPressed: () async {
                        if (await canLaunch(
                            "https://goo.gl/maps/FyU3ByvFTjPrVT2o7")) {
                          await launch("https://goo.gl/maps/FyU3ByvFTjPrVT2o7");
                        }
                      },
                    ),
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 38.0,
                    ),
                    onTap: () {}),
              ]));
  }

  @override
  void initState() {
    etablissement(Provider.of<LoginProvider>(context, listen: false).tokenuser);

    super.initState();
  }
}
