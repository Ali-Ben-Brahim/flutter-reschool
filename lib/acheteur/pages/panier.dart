import '../pages/modal_commande.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class Panier extends StatefulWidget {
  const Panier({ Key? key }) : super(key: key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
                child: Consumer<Cart>(builder: (context, cart, child){
                  return cart.listeAchat.isEmpty? const Text('') : Container(
                    
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height-300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cart.nbre,
                            itemBuilder:  (context , i){
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            'https://www.paprec.com/wp-content/uploads/2020/10/dechets_menagers_non_recyclable.png', 
                                            height: 120,
                                            fit: BoxFit.fill,
                                          ),
                                          const SizedBox(width: 10,),
                                          Column(
                                            children: [
                                              Text("${cart.listeAchat[i]['type']['type_dechet']}"),
                                              const SizedBox(height: 8,),
                                              Text("${cart.listeAchat[i]['type']['prix_unitaire']} dt/kg"),
                                              const SizedBox(height: 8,),
                                              
                                            ],
                                          ),
                                          Expanded(child: Container()),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0,0,15,0),
                                            child: InkWell(
                                              onTap: (){
                                                cart.remove(cart.listeAchat[i]);
                                              },
                                              child: const Icon(Icons.delete , color: Colors.red,),
                                            ),
                                          ), 
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container()),
                                          Text('${cart.listeAchat[i]['qte']} Kg'),
                                          Expanded(child: Container()),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0,0,15,0),
                                            child: Text("${cart.listeAchat[i]['total']} DT"),
                                          ),
                                        
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10.0 , 5 ,10.0 , 5),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(75, 174, 79,1),
                                ),
                            onPressed: (){      
                              ModalCommande.modal(cart, context);                        
                              },
                            child: Text('Aller à la caisse ${cart.price} DT')
                           ),
                        )
                      ],
                    ),
                  );
                },
              ),
              
            )
    );
  }
}

