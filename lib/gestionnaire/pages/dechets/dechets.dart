import 'package:estionnaire/gestionnaire/provider/dechets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ajouter_dechet.dart';
import 'modifier_dechet.dart';

class Dechets extends StatefulWidget {
  const Dechets({Key? key}) : super(key: key);

  @override
  State<Dechets> createState() => _DechetsState();
}

class _DechetsState extends State<Dechets> {
  @override
  Widget build(BuildContext context) {
    Provider.of<DechetsProvider>(context,listen: false).allDechets();
    bool load =Provider.of<DechetsProvider>(context).isLoading;
    List data = Provider.of<DechetsProvider>(context).dechets;
    return  Scaffold(
      body: load?  const Center(child: CircularProgressIndicator())
      :data.isEmpty?const Center(child: Text('Il n\'y a pas de deches'),) 
      :Column(
        children: [
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text("${data[index]['type_dechet']}"),
                    subtitle: Text("${data[index]['prix_unitaire']}"),
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
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ModifierDechet(dechets: data[index],)));
                              },
                              child:const Icon(Icons.edit,color: Colors.green,),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),    
                          SizedBox(
                            width:30,
                            child: InkWell(
                              onTap: (){
                                Provider.of<DechetsProvider>(context,listen: false).deleteDechets(data[index]['id']);
                              },
                              child:const Icon(Icons.delete,color: Colors.red,),
                            ),
                          ), 
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const AjouterDechet()));
            },
            child:const SizedBox(
              width: double.infinity,
              child: Center(child: Text('Ajouter')),
            ) 
          )
        ],
      )
    );
  }
}