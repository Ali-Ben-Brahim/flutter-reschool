import 'package:flutter/material.dart';
import '../Composants/app_bar.dart';
import '../Pages/HomePage.dart';

class AcceuilResponsableEtablissement extends StatelessWidget {
  const AcceuilResponsableEtablissement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List acceuil = [
      {
        "image": "assets/images/dashboard.png",
        "title": "Dashboard",
        "page": HomePage(
          num: 0,
        )
      },
      {
        "image": "assets/images/calendar.png",
        "title": "Planning",
        "page": HomePage(
          num: 1,
        )
      },
      {
        "image": "assets/images/map.png",
        "title": "Map",
        "page": HomePage(
          num: 2,
        )
      },
      {
        "image": "assets/images/support.png",
        "title": "Service Client",
        "page": HomePage(
          num: 3,
        )
      },
      {
        "image": "assets/images/settings.png",
        "title": "Paramètres",
        "page": HomePage(
          num: 4,
        )
      },
    ];
    var size = MediaQuery.of(context).size;

 
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: getAppbar("Accueil"),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: acceuil.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => acceuil[index]["page"]),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(acceuil[index]["image"]),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Flexible(
                    child: Text(
                      acceuil[index]["title"],
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
