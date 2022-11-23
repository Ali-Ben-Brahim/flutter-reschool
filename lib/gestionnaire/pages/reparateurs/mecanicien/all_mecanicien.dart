


// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:estionnaire/gestionnaire/pages/reparateurs/mecanicien/modifier_mecanicien.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/reparateurs_provider.dart';
import 'ajouter_mecanicien.dart';

class Mecanicien extends StatefulWidget {

  const Mecanicien({Key? key}) : super(key: key);

  @override
  State<Mecanicien> createState() => _MecanicienState();
}


class _MecanicienState extends State<Mecanicien> {
  
  
  @override
  Widget build(BuildContext context) {
    Provider.of<ReparateursProvider>(context,listen: false).allMecanicien();
    List data=Provider.of<ReparateursProvider>(context,listen:true).mecanicien;
    bool load=Provider.of<ReparateursProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Tous les mecaniciens'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:12),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const AjouterMecanicien())
                );
              },
              child:const Icon(Icons.add),
            ),
          )
        ],
      ),
      body:load? const Center(child: CircularProgressIndicator(),) :data.isNotEmpty? ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return Card(
            child: ListTile(
              title: Text("${data[index]['nom']} ${data[index]['prenom']}"),
              subtitle: Text("${data[index]['email']}"),
              trailing: SizedBox(
                width: 80,
                height: 50,
                child: Row(
                  children:[
                    SizedBox(
                      width: 30,
                      child: InkWell(
                        onTap: ()async{
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>ModifierMecanicien(mecanicien: data[index],)
                          ));
                        },
                        child:const Icon(Icons.edit,color: Colors.blue,),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),    
                    SizedBox(
                      width:30,
                      child: InkWell(
                        onTap: (){
                          Provider.of<ReparateursProvider>(context,listen: false).deleteMecanicien(data[index]['id']);
                        },
                        child:const Icon(Icons.delete,color: Colors.red,),
                      ),
                    ), 
                  ],
                ),
              ),
            )
          );
        },
      ):const Center(child: Text("il n'y a pas de mecanicien"))
    );
  }
}
