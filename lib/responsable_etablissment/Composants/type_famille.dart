import 'package:flutter/material.dart';
import '../Pages/type_famille.dart';


import '../constans.dart';


class Famille extends StatefulWidget {
  const Famille({Key? key}) : super(key: key);

  @override
  State<Famille> createState() => _FamilleState();
}

class _FamilleState extends State<Famille> {
  List type=[
   { "img":"assets/images/plastique.png",
     "title": "Famille Plastique",
     "page" :  const TYPEFAMILLE(type: "plastique",)
   },
    { "img":"assets/images/canette.png",
     "title": "Famille Canette",
     "page" : const TYPEFAMILLE(type: "canette",)
   },
    { "img":"assets/images/papier.png",
     "title": "Famille papier",
     "page" : const TYPEFAMILLE(type: "papier",)
   },
    { "img":"assets/images/composte.png",
     "title": "Famille composte",
     "page" : const TYPEFAMILLE(type: "composte",)
   },
  ];
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      
            itemCount: type.length,
            itemBuilder: (BuildContext ctx, int index) {

              return Card(
                margin: const EdgeInsets.all(20),
                color: secondaryColor,
                
            elevation: 5,
            child: ListTile(
              leading: Image.asset(
                    '${type[index]['img']}',width: 40,height: 40,),
              title:  Text(type[index]["title"],
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25)),
                        onTap: (){
                           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => type[index]["page"]),
            );
                        },
             
            ),
          );
  }
   
   ),
    );
  }
}


       