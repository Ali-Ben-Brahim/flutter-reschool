


// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:estionnaire/gestionnaire/pages/ouvrier/ajouter_ouvrier.dart';
import 'package:estionnaire/gestionnaire/pages/ouvrier/modifier_ouvrier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/ouvrier_provider.dart';

class AllOuvrier extends StatefulWidget {

  const AllOuvrier({Key? key}) : super(key: key);

  @override
  State<AllOuvrier> createState() => _AllOuvrierState();
}


class _AllOuvrierState extends State<AllOuvrier> {
  
  
  @override
  Widget build(BuildContext context) {
    Provider.of<OuvrierProvider>(context,listen: false).allOuvrier();
    List data=Provider.of<OuvrierProvider>(context,listen:true).ouvrier;
    bool load=Provider.of<OuvrierProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Tous les ouvriers'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:12),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const AjouterOuvrier())
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
                            MaterialPageRoute(builder: (context)=>ModifierOuvrier(ouvrier: data[index],)
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
                          Provider.of<OuvrierProvider>(context,listen: false).deleteOuvrier(data[index]['id']);
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
