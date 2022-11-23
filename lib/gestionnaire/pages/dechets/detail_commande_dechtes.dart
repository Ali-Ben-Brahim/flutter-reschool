

import 'package:estionnaire/gestionnaire/provider/dechets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsCommandeDechets extends StatefulWidget {
  const DetailsCommandeDechets({Key? key}) : super(key: key);

  @override
  State<DetailsCommandeDechets> createState() => _DetailsCommandeDechetsState();
}

class _DetailsCommandeDechetsState extends State<DetailsCommandeDechets> {
  @override
  Widget build(BuildContext context) {
    Provider.of<DechetsProvider>(context,listen: false).allDetailsCommandeDechets();
    bool load =Provider.of<DechetsProvider>(context).isLoading;
    List data = Provider.of<DechetsProvider>(context).detailsCommandeDechets;
    return  Scaffold(
      body: load?  const Center(child: CircularProgressIndicator())
      :data.isEmpty?const Center(child: Text('Il n\'y a pas de details commande deches'),) 
      :SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      title: Text("Commande n° ${data[index]['commande_dechet_id']}"),
                      subtitle:Text("${data[index]['dechet']}"),
                      trailing: SizedBox(
                        width: 80,
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
                              width:30,
                              child: InkWell(
                                onTap: (){
                                  Provider.of<DechetsProvider>(context,listen: false).deleteDetailsCommandeDechets(data[index]['id']);
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
          ],
        ),
      )
    );
  }
}