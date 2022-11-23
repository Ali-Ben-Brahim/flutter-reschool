// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../Composants/app_bar.dart';

class Commander extends StatefulWidget {
  const Commander({Key? key}) : super(key: key);

  @override
  State<Commander> createState() => _CommanderState();
}

class _CommanderState extends State<Commander> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: getAppbar("Achat"),
      body: const Center(
        child: Text("Commander"),
      ),
    );
  }
}
