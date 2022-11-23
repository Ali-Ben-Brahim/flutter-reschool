// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Parametre extends StatefulWidget {
  const Parametre({Key? key}) : super(key: key);

  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Parametre"),
      ),
    );
  }
}
