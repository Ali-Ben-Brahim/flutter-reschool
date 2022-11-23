


// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:estionnaire/gestionnaire/pages/client/ajouter_clients.dart';
import 'package:estionnaire/gestionnaire/pages/client/modifier_clients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/client_provider.dart';


class AllClients extends StatefulWidget {

  const AllClients({Key? key}) : super(key: key);

  @override
  State<AllClients> createState() => _AllClientsState();
}


class _AllClientsState extends State<AllClients> {
  
  
  @override
  Widget build(BuildContext context) {
    Provider.of<ClientProvider>(context,listen: false).allClient();
    List data=Provider.of<ClientProvider>(context,listen:true).clients;
    bool load=Provider.of<ClientProvider>(context).isloading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Tous les Clients'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:12),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const AjouterClient())
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
              title: Text("${data[index]['nom_responsable']} | Entreprise : ${data[index]['nom_entreprise']}"),
              subtitle: Text("${data[index]['email']}"),
              trailing: SizedBox(
                width: 120,
                height: 50,
                child: Row(
                  children:[
                    SizedBox(
                      width: 30,
                      child: InkWell(
                        onTap: (){
                        },
                        child:const Icon(Icons.visibility,color: Colors.orange,),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 30,
                      child: InkWell(
                        onTap: ()async{
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>ModifierClient(client: data[index],)
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
                          Provider.of<ClientProvider>(context,listen: false).deleteClient(data[index]['id']);
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
      ):const Center(child: Text("Il n'y a pas des clients"))
    );
  }
}
