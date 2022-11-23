import 'package:flutter/material.dart';
class Apropos extends StatefulWidget {
  const Apropos({ Key? key }) : super(key: key);

  @override
  _AproposState createState() => _AproposState();
}

class _AproposState extends State<Apropos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("A propos"),
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
      ),
      body:const Text("A propos"),
      
    );
  }
}