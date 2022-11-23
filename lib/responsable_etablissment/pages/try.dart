import 'package:estionnaire/responsable_etablissment/provider/planning_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../gestionnaire/provider/login_provider.dart';

class TryPage extends StatefulWidget {
  TryPage({Key? key}) : super(key: key);

  @override
  State<TryPage> createState() => _TryPageState();
}

class _TryPageState extends State<TryPage> {
  @override
  void initState() {

    final postModel = Provider.of<PlanningClass>(context, listen: false);
    postModel.getPostData(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<PlanningClass>(context, listen: true);
    return Scaffold(
        body: postModel.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : postModel.post?.lundi![1].isEmpty
                ? Text('nothing')
                : Text("${postModel.post?.lundi![1]}"));
  }
}
