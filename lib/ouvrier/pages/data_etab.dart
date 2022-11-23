import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../gestionnaire/provider/login_provider.dart';
import '../provider/etab_class.dart';

class EtabData extends StatefulWidget {
  EtabData({Key? key}) : super(key: key);

  @override
  State<EtabData> createState() => _EtabDataState();
}

class _EtabDataState extends State<EtabData> {
  @override
  void initState() {
    final postModel = Provider.of<EtabClass>(context, listen: false);
    postModel.getPostData(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     final postModel = Provider.of<EtabClass>(context);
    return Scaffold(body: postModel.loading?Center(child: CircularProgressIndicator()) :Center(child: Text("${postModel.post!.id}")),);
  }
}