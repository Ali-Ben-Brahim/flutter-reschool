// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../gestionnaire/provider/login_provider.dart';
import '../Composants/date_sys.dart';
import '../Data/Dashboard1.dart';
import '../constans.dart';

import '../Composants/app_bar.dart';
import '../Composants/partie3.dart';
import '../Composants/type_famille.dart';
import '../provider/etablssment_data_class.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({Key? key}) : super(key: key);

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  @override
  void initState() {
    final postModel =
        Provider.of<EtablissementDataClass>(context, listen: false);
    postModel.getEtablissmentdata(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postModel1 = Provider.of<EtablissementDataClass>(context);

    return postModel1.loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: bgColor,
            appBar:
                getAppbar("Dashboard: ${postModel1.post?.nomEtablissement}"),
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Center(child: DateSys()),
                    Dashbord1(),
                    Famille(),
                    StarageDetails(),
                  ],
                ),
              ),
            ),
          );
  }
}
