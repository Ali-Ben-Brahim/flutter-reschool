


// ignore_for_file: no_leading_underscores_for_local_identifiers


import 'package:estionnaire/gestionnaire/pages/responsable_etablissement/modifier_responsable_etablissement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/responsable_etablissement_provider.dart';
import 'ajouter_responsable_etablissement.dart';



class AllResponsablesEtablissment extends StatefulWidget {

  const AllResponsablesEtablissment({Key? key}) : super(key: key);

  @override
  State<AllResponsablesEtablissment> createState() => _AllResponsablesEtablissmentState();
}


class _AllResponsablesEtablissmentState extends State<AllResponsablesEtablissment> {
  
  
  @override
  Widget build(BuildContext context) {
    Provider.of<ResponsableEtablissmentProvider>(context,listen: false).allResponsables();
    List data=Provider.of<ResponsableEtablissmentProvider>(context,listen:true).responsables;
    bool load=Provider.of<ResponsableEtablissmentProvider>(context).isloading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Tous les Responsables des etablissments'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:12),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const AjouterRespnsable())
                );
              },
              child:const Icon(Icons.add),
            ),
          )
        ],
      ),
      body:
      load? const Center(child: CircularProgressIndicator(),) :data.isNotEmpty? ListView.builder(
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
                            MaterialPageRoute(builder: (context)=>ModifierRespnsable(responsable: data[index],)
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
                          Provider.of<ResponsableEtablissmentProvider>(context,listen: false).deleteResponsable(data[index]['id']);
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
      ):const Center(child: Text("Il n'y a pas des responsables des etablissments"))
    );
  }
}
