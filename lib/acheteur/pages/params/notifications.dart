import 'package:flutter/material.dart';

class Notif extends StatefulWidget {
  const Notif({ Key? key }) : super(key: key);

  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Notifications"),
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
      ),
      body: const Text("Notifications"),
    );
  }
}