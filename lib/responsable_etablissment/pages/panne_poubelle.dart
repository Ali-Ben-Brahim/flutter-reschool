// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PannePoubelle extends StatefulWidget {
  const PannePoubelle({Key? key}) : super(key: key);

  @override
  State<PannePoubelle> createState() => _PannePoubelleState();
}

class _PannePoubelleState extends State<PannePoubelle> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("PannePoubelle"),
      ),
    );
  }
}
