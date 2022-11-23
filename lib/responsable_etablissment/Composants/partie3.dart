import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../gestionnaire/provider/login_provider.dart';
import '../Data/data-part.dart';
import '../provider/data_class.dart';
import 'chart.dart';
import '../constans.dart';

class StarageDetails extends StatefulWidget {
  const StarageDetails({Key? key}) : super(key: key);

  @override
  State<StarageDetails> createState() => _StarageDetailsState();
}

class _StarageDetailsState extends State<StarageDetails> {
  @override
  void initState() {
    final postModel1 = Provider.of<DataClass>(context, listen: false);
    postModel1.getPostData(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postModel1 = Provider.of<DataClass>(context);
    return postModel1.loading
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Taux de remplissage",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    const Chart(),
                    StorageInfoCard(
                      svgSrc: "assets/images/plastique.png",
                      title: const Text("Plastique",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Color(0xFF26E5FF))),
                      amountOfFiles:
                          "${Provider.of<DataClass>(context, listen: false).post?.poucentageTotalePlastique} %",
                      numOfFiles: Provider.of<DataClass>(context, listen: false)
                          .post
                          ?.sommeQtePlastique,
                    ),
                    StorageInfoCard(
                      svgSrc: "assets/images/canette.png",
                      title: const Text("Canette",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Color(0xFFEE2727))),
                      amountOfFiles:
                          "${Provider.of<DataClass>(context, listen: false).post?.poucentageTotaleCanette} %",
                      numOfFiles: Provider.of<DataClass>(context, listen: false)
                          .post
                          ?.sommeQteCanette,
                    ),
                    StorageInfoCard(
                      svgSrc: "assets/images/papier.png",
                      title: const Text("Papier",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Color(0xFFFFCF26))),
                      amountOfFiles:
                          "${Provider.of<DataClass>(context, listen: false).post?.poucentageTotalePapier} %",
                      numOfFiles: Provider.of<DataClass>(context, listen: false)
                          .post
                          ?.sommeQtePapier,
                    ),
                    StorageInfoCard(
                      svgSrc: "assets/images/composte.png",
                      title: const Text("composte",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color.fromARGB(255, 67, 227, 22))),
                      amountOfFiles:
                          "${Provider.of<DataClass>(context, listen: false).post?.poucentageTotaleComposte} %",
                      numOfFiles: Provider.of<DataClass>(context, listen: false)
                          .post
                          ?.sommeQteComposte,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
