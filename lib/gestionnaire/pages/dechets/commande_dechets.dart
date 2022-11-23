

import 'package:estionnaire/gestionnaire/provider/dechets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommandeDechets extends StatefulWidget {
  const CommandeDechets({Key? key}) : super(key: key);

  @override
  State<CommandeDechets> createState() => _CommandeDechetsState();
}

class _CommandeDechetsState extends State<CommandeDechets> {
  @override
  Widget build(BuildContext context) {
    Provider.of<DechetsProvider>(context,listen: false).allCommandeDechets();
    bool load =Provider.of<DechetsProvider>(context).isLoading;
    List data = Provider.of<DechetsProvider>(context).commandeDechets;
    return  Scaffold(
      body: load?  const Center(child: CircularProgressIndicator())
      :data.isEmpty?const Center(child: Text('Il n\'y a pas de commande deches'),) 
      : SingleChildScrollView(
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
                      title: Text("Commande n° ${data[index]['id']}"),
                      subtitle: Text("Montant : ${data[index]['montant_total']} DT"),
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
                                  Provider.of<DechetsProvider>(context,listen: false).deleteCommandeDechets(data[index]['id']);
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