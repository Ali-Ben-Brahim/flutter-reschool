
import 'dart:convert';

import '../provider/auth_provider.dart';
import '../provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../services/dechets_service.dart';
import 'accueil.dart';
class ModalCommande{


  
  static Future modal(cart , context)async{
    UserModel? client = Provider.of<AuthProvider>(context,listen: false).user;
    DechetService dechetService =DechetService();
    return showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
                                ),
                                 builder: (BuildContext builder){
                                   return Container(
                                       child: ListView(
                                         children: [
                                           //Divider
                                           Container(
                                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.3 , vertical: 5),
                                              child: const Divider(
                                                thickness: 4,
                                                color: Color.fromRGBO(172, 172, 172, 1),
                                              ),
                                            ),
                                           // Verifier
                                           const ListTile(
                                             title: Text(
                                               "Vérifier",
                                               style: TextStyle(
                                                 fontSize: 35,
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.black
                                                ),
                                              ),
                                           ),
                                           //Divider
                                           const Divider(
                                             thickness: 1,
                                             color: Color.fromRGBO(227, 227, 227, 1),
                                           ),
                                           //Livraison
                                           InkWell(
                                             onTap: (){},
                                             child: const ListTile(
                                               title:Text(
                                                 "Livraison",
                                                 style: TextStyle(
                                                   color: Color.fromRGBO(130, 130, 130, 1),
                                                 ),
                                              ),
                                              trailing: Text(
                                                "Sélectionner la méthode  >",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(13, 13, 13, 1), 
                                                  fontWeight: FontWeight.bold
                                                ),),
                                             ),
                                           ),
                                          //Divider
                                           const Divider(
                                             thickness: 1,
                                             color: Color.fromRGBO(227, 227, 227, 1),
                                           ),
                                          //Paiement
                                          InkWell(
                                             onTap: (){},
                                             child: const ListTile(
                                               title:Text(
                                                 "Paiement",
                                                 style: TextStyle(
                                                   color: Color.fromRGBO(130, 130, 130, 1),
                                                 ),
                                              ),
                                              trailing: Icon(
                                                Icons.credit_card,
                                                color: Color.fromRGBO(13, 13, 13, 1), 
                                              )
                                             ),
                                           ),
                                         //Divider
                                           const Divider(
                                             thickness: 1,
                                             color: Color.fromRGBO(227, 227, 227, 1),
                                           ),
                                         // Promo code 
                                          InkWell(
                                             onTap: (){},
                                             child: const ListTile(
                                               title:Text(
                                                 "Promo code",
                                                 style: TextStyle(
                                                   color: Color.fromRGBO(130, 130, 130, 1),
                                                 ),
                                              ),
                                              trailing: Text(
                                                "Entrer code >",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(13, 13, 13, 1),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                             ),
                                           ),
                                          //Divider
                                           const Divider(
                                             thickness: 1,
                                             color: Color.fromRGBO(227, 227, 227, 1),
                                           ),
                                          //total
                                          InkWell(
                                             onTap: (){},
                                             child:  ListTile(
                                               title:const Text(
                                                 "Total",
                                                 style: TextStyle(
                                                   color: Color.fromRGBO(130, 130, 130, 1),
                                                 ),
                                              ),
                                              trailing: Text(
                                                "${cart.price} DT",
                                                style: const TextStyle(color: Color.fromRGBO(13, 13, 13, 1),
                                                fontWeight: FontWeight.bold,
                                                ),
                                              )
                                             ),
                                           ),
                                         //Divider
                                           const Divider(
                                             thickness: 1,
                                             color: Color.fromRGBO(227, 227, 227, 1),
                                           ),
                                         Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 50),
                                           child: ElevatedButton(
                                             style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color.fromRGBO(75, 174, 79,1),
                                              ),
                                             onPressed: ()async{
                                               dynamic res=await dechetService.commander(
                                                 client!.id.toString(),
                                                 jsonEncode(cart.listeAchat),
                                                 'en ligne',
                                                 cart.price.toString(),
                                                 Provider.of<AuthProvider>(context,listen: false).tokens
                                                );
                                               if(res == 200){
                                                 Provider.of<Cart>(context,listen: false).removeAll();
                                                 
                                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                  Accueil(index: 1)), (Route<dynamic> route) => false);
                                               }
                                             },
                                             child: const Text("Passer la commande")),
                                         )
                                         ],
                                       ),
                                   );
                                 }
                              );
                            
  }
}