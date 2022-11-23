import '../provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class Parametre extends StatefulWidget {
  const Parametre({ Key? key }) : super(key: key);

  @override
  _ParametreState createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  final parametres =[
    {"parametre":"Notification" , "page" : "/Notification" },
    {"parametre":"Changer coordonne" , "page" : "/ChangerCoordonne"},
    {"parametre":"Changer mot de passe" , "page" : "/ChangerMotDePasse"},
    {"parametre":"À propos" , "page" : "/Apropos"},
    {"parametre":"Déconnexion" , "page" : "/Deconnexion"},
  ];
  final icons = [
    Icons.notifications_outlined,
    Icons.person_outlined,
    Icons.password_outlined,
    Icons.error_outline_outlined,
    Icons.logout_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("parametres"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
      ),
      body: Container(
        margin:const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: parametres.length,
          itemBuilder: (context, index) {
            return Container(
              margin:const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: InkWell(
                onTap: ()async{
                  if(parametres[index]["page"] != '/Deconnexion'){
                    Get.toNamed('${parametres[index]["page"]}');
                  }else{
                   await Provider.of<AuthProvider>(context,listen: false).logout();
                    Get.offAllNamed("/Login");
                  }
                },
                child: Card( //                         
                      child: ListTile(
                        leading: Icon(icons[index]),
                title: Text('${parametres[index]["parametre"]}',
                style: const TextStyle( fontSize: 20),
                ),
                trailing : IconButton(
                  onPressed: (){
                    if(parametres[index]["page"] != '/Deconnexion'){
                    Get.toNamed('${parametres[index]["page"]}');
                  }else{
                    Get.toNamed("/Login");
                  }
                  },
                  icon:const Icon(
                    Icons.edit_outlined ,size: 30,color: Color(0xFF81C784),) ,
                  )
                      ),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}