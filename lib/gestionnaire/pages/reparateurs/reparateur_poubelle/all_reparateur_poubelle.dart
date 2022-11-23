


// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:estionnaire/gestionnaire/pages/reparateurs/reparateur_poubelle/ajouter_reparateur_poubelle.dart';
import 'package:estionnaire/gestionnaire/pages/reparateurs/reparateur_poubelle/modifier_reparateur_poubelle.dart';
import 'package:estionnaire/gestionnaire/provider/reparateurs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class allRepateurPoubelle extends StatefulWidget {

  const allRepateurPoubelle({Key? key}) : super(key: key);

  @override
  State<allRepateurPoubelle> createState() => _allRepateurPoubelleState();
}


class _allRepateurPoubelleState extends State<allRepateurPoubelle> {
  
  
  @override
  Widget build(BuildContext context) {
    Provider.of<ReparateursProvider>(context,listen: false).allRepateurPoubelle();
    List data=Provider.of<ReparateursProvider>(context,listen:true).reparateurPoubelle;
    bool load=Provider.of<ReparateursProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Tous les reparateurs poubelle'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:12),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const AjouterRepateurPoubelle())
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
                            MaterialPageRoute(builder: (context)=>ModifierReparateurPoubelle(reparateur_poubelle: data[index],)
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
                          Provider.of<ReparateursProvider>(context,listen: false).deleteRepateurPoubelle(data[index]['id']);
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
      ):const Center(child: Text("il n'y a pas d'ouvrier"))
    );
  }
}
