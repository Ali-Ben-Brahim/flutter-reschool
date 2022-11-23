// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:estionnaire/responsable_etablissment/Composants/box_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../gestionnaire/provider/login_provider.dart';

import '../provider/data_class.dart';
import '../provider/etablssment_data_class.dart';

class Dashbord1 extends StatefulWidget {
  const Dashbord1({Key? key}) : super(key: key);

  @override
  State<Dashbord1> createState() => _Dashbord1State();
}

class _Dashbord1State extends State<Dashbord1> {
  @override
  void initState() {
    final postModel0 =
        Provider.of<EtablissementDataClass>(context, listen: false);
    postModel0.getEtablissmentdata(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
    final postModel1 = Provider.of<DataClass>(context, listen: false);
    postModel1.getPostData(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postModel0 = Provider.of<EtablissementDataClass>(context);
    final postModel1 = Provider.of<DataClass>(context);
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return postModel1.loading || postModel0.loading
        ? const Center(child: CircularProgressIndicator())
        : 
        SafeArea(
            child: GridView.count(
              shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            padding: const EdgeInsets.all(20),
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              BoxGrid(
                image: "plastique",
                pourcentage: postModel1.post?.poucentagePlastique,
                somme: postModel1.post?.sommeQtePlastique,
                nbr: postModel0.post?.nbrPoubellePlastique,
              ),
              BoxGrid(
                image: "canette",
                pourcentage: postModel1.post?.poucentageCanette,
                somme: postModel1.post?.sommeQteCanette,
                nbr: postModel0.post?.nbrPoubelleCanette,
              ),
              BoxGrid(
                image: "papier",
                pourcentage: postModel1.post?.poucentagePapier,
                somme: postModel1.post?.sommeQtePapier,
                nbr: postModel0.post?.nbrPoubellePapier,
              ),
              BoxGrid(
                image: "composte",
                pourcentage: postModel1.post?.poucentageComposte,
                somme: postModel1.post?.sommeQteComposte,
                nbr: postModel0.post?.nbrPoubelleComposte,
              ),
            ],
          ));
  }
}
