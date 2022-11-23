import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../gestionnaire/provider/login_provider.dart';
import '../provider/etab_class.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Set<Marker> markers = {};
  double lat = 0.0;
  double long = 0.0;
  getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude;
      long = position.longitude;
     

    });
  }
  

  @override
  void initState() {
    getCurrentPosition();
       final postModel = Provider.of<EtabClass>(context, listen: false);
    postModel.getPostData(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
    super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition getCameraPostion() {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
     final postModel = Provider.of<EtabClass>(context, listen: true);
   
    
  //  List.generate(postModel.post!.id.length , (i) {
  //     dynamic infos = postModel.post!.id[i];

  //     markers.add(
  //       Marker(
        
  //         markerId: MarkerId(infos['nom_etablissement'].toString()),
  //         position: LatLng(
  //             infos['latitude'].toDouble(), infos['longitude'].toDouble()),
  //         infoWindow: InfoWindow(
  //           title: infos['nom_etablissement'],
  //         ),
          
  //       ),
  //     );
  //   });
    return Scaffold(
      body: lat == 0.0 ||postModel.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.normal,
              markers: markers,
              initialCameraPosition: getCameraPostion(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
