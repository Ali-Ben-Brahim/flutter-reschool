import 'dart:async';

import 'package:badges/badges.dart';

import '../pages/panier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/achat_model.dart';
import '../provider/cart_provider.dart';
import '../services/dechets_service.dart';
import '../services/url_db.dart';
class Commander extends StatefulWidget {
  const Commander({ Key? key }) : super(key: key);

  @override
  _CommanderState createState() => _CommanderState();
}

class _CommanderState extends State<Commander> {
  List <Widget> QuantitesTotalRamasse =[];


  final TextEditingController _quantitePlastiqueController = TextEditingController();
  final TextEditingController _quantiteComposteController = TextEditingController();
  final TextEditingController _quantitePapierController = TextEditingController();
  final TextEditingController _quantiteCanetteController = TextEditingController();

  var timer;
  List _Allprice =[];
  // List dropdownValuePaiementList= ['Paiement en ligne', 'Paiement en espece', 'Paiement par cheque'];
  // String dropdownValuePaiement = 'Paiement en ligne';
  @override
  
  void initState() {
    super.initState();
    getData();
    if(mounted){
    timer = Timer.periodic(const Duration(seconds: 4) , (Timer t) {
      getData();
      });    
    }
  }

  getData() async{
    List dataDechets = [] ;
    dataDechets =await alldechet();   
    if(mounted){
      setState(() {
        _Allprice =dataDechets;
      });
    }
    }
  
  @override
  void dispose() {
    if(mounted){
    timer.cancel();

    }
    super.dispose();   
  }
     
  @override
  Widget build(BuildContext context) {
    dynamic provider = Provider.of<Cart>(context, listen: true);
    Timer timer;
    
      if(mounted){
        if(provider.commandeEffectuee){
          timer = Timer.periodic(const Duration(seconds: 5), (timer) {
              provider.setCommandeEffectuee();
              timer.cancel();
           });
        }
      }
    
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: (){
                
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>const Panier()));
              },
              child: Badge(
                badgeContent: Text('${Provider.of<Cart>(context,listen: false).nbre}' , style: const TextStyle(color: Colors.white) ,),
                position: BadgePosition.topEnd(top: 7, end: -8),
                animationDuration: const Duration(milliseconds: 30),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              
            ),
            const SizedBox(width: 20.0,)
          ],
          title: const Text("ACHAT"),
          backgroundColor: const Color.fromRGBO(75, 174, 79,1),
          centerTitle: true,
        ),
        body:provider.commandeEffectuee ?AlertDialog(
            title: const Text('Commande effectuée'),
            content: InkWell(
              onTap: (){
                  provider.setCommandeEffectuee();
              },
              child:const CircleAvatar(
                backgroundColor: Colors.green,
                radius: 30,
                child: Icon(Icons.check ,color:Colors.white,)
              ),
            ),
          ) : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side:const BorderSide(color: Colors.blueGrey, width: 0.5),
                ),
                child: const Text('solde'),
              ),
              Expanded(
                child:_Allprice.isEmpty ? Container():GridView.builder(
                  
                  scrollDirection: Axis.vertical,
                  itemCount: _Allprice.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2/3,      
                  ), 
                  itemBuilder: (BuildContext ctx, index){
                    return SizedBox(
                     width: double.infinity,
                     height: 300,
                      child: Card(
                        semanticContainer: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side:const BorderSide(color: Colors.blueGrey, width: 0.5),
                        ),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            _Allprice[index]['photo'] !=null ?
                             Image.network(
                                "$baseURL/storage/images/dechet/${_Allprice[index]['photo']}",
                                height: 70,
                            // Text("${_Allprice[index]['photo']}"
                            ):Container(),
                            Text(
                              "${_Allprice[index]['type_dechet']}",
                              style:const TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${_Allprice[index]['prix_unitaire']} dt/kg",
                              style:const TextStyle(fontSize: 15)
                            ),
                            
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color:const Color.fromRGBO(244, 67, 54, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(
                                    onPressed: (){
                                      try{

                                        if(_Allprice[index]['type_dechet']=='plastique'){
                                          if(provider.quantitePlastique >0){
                                            Provider.of<Cart>(context,listen: false).removeQuantitePlastique();
                                            var qte = int.parse(_quantitePlastiqueController.text.toString().trim())-10;
                                            setState(() {
                                              _quantitePlastiqueController.text =  qte.toString();
                                            });
                                          }
                                          if(provider.quantitePlastique <0){
                                            Provider.of<Cart>(context,listen: false).setQuantitePlastique(0);
                                            setState(() {
                                              _quantitePlastiqueController.text =  0.toString();
                                            });
                                          }
                                        }
                                        if(_Allprice[index]['type_dechet']=='composte'){
                                          if(provider.quantiteComposte >0){
                                            Provider.of<Cart>(context,listen: false).removeQuantiteComposte();
                                            var qte = int.parse(_quantiteComposteController.text.toString().trim())- 10;
                                            setState(() {
                                              _quantiteComposteController.text =  qte.toString();
                                            });
                                          }
                                          if(provider.quantiteComposte <0){
                                            Provider.of<Cart>(context,listen: false).setQuantiteComposte(0);
                                            setState(() {
                                              _quantiteComposteController.text =  0.toString();
                                            });
                                          }
                                        }
                                        if(_Allprice[index]['type_dechet']=='papier'){
                                          if(provider.quantitePapier >0){
                                            Provider.of<Cart>(context,listen: false).removeQuantitePapier();
                                            var qte = int.parse(_quantitePapierController.text.toString().trim())- 10;
                                            setState(() {
                                              _quantitePapierController.text =  qte.toString();
                                            });
                                          }
                                          if(provider.quantitePapier <0){
                                            Provider.of<Cart>(context,listen: false).setQuantitePapier(0);
                                            setState(() {
                                              _quantitePapierController.text =  0.toString();
                                            });
                                          }
                                        }
                                        if(_Allprice[index]['type_dechet']=='canette'){
                                          if(provider.quantiteCanette >0){
                                            Provider.of<Cart>(context,listen: false).removeQuantiteCanette();
                                            var qte = int.parse(_quantiteCanetteController.text.toString().trim())- 10;
                                            setState(() {
                                              _quantiteCanetteController.text =  qte.toString();
                                            });
                                          }
                                          if(provider.quantiteCanette <0){
                                            Provider.of<Cart>(context,listen: false).setQuantiteCanette(0);
                                            setState(() {
                                              _quantiteCanetteController.text =  0.toString();
                                            });
                                          }
                                        }
                                      }catch(_){}
                                      
                                    },
                                    icon: const Icon(Icons.remove, size: 18,)
                                  ),
                                ),
                               
                                Expanded(
                                  child: Center(
                                    child: _Allprice[index]['type_dechet']=='plastique'?
                                    //Plastique
                                    TextField (
                                      controller: _quantitePlastiqueController,
                                      decoration: InputDecoration(labelText: "${provider.quantitePlastique} KG"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly
                                        ], 
                                      onChanged: (value){
                                        int  i =0;
                                        if(value.isNotEmpty){
                                          i= int.parse(value.toString());

                                          Provider.of<Cart>(context,listen: false).setQuantitePlastique(i);
                                        }else{
                                          i=0;
                                          Provider.of<Cart>(context,listen: false).setQuantitePlastique(i);
                                        }

                                      },
                                      ) :
                                     _Allprice[index]['type_dechet']=='composte' ?
                                     //Composte
                                     TextField (
                                      controller: _quantiteComposteController,
                                      decoration: InputDecoration(labelText: "${provider.quantiteComposte} KG"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly
                                        ], 
                                      onChanged: (value){
                                        int  i =0;
                                        if(value.isNotEmpty){
                                          i= int.parse(value.toString());

                                          Provider.of<Cart>(context,listen: false).setQuantiteComposte(i);
                                        }else{
                                          i=0;
                                          Provider.of<Cart>(context,listen: false).setQuantiteComposte(i);
                                        }

                                      },
                                      ) :
                                    _Allprice[index]['type_dechet']=='papier' ?
                                    //Papier
                                    TextField (
                                      controller: _quantitePapierController,
                                      decoration: InputDecoration(labelText: "${provider.quantitePapier} KG"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly
                                        ], 
                                      onChanged: (value){
                                        int  i =0;
                                        if(value.isNotEmpty){
                                          i= int.parse(value.toString());

                                          Provider.of<Cart>(context,listen: false).setQuantitePapier(i);
                                        }else{
                                          i=0;
                                          Provider.of<Cart>(context,listen: false).setQuantitePapier(i);
                                        }

                                      },
                                    ) :
                                    //Canette
                                    TextField (
                                      controller: _quantiteCanetteController,
                                      decoration: InputDecoration(labelText: "${provider.quantiteCanette} KG"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly
                                        ], 
                                      onChanged: (value){
                                        int  i =0;
                                        if(value.isNotEmpty){
                                          i= int.parse(value.toString());

                                          Provider.of<Cart>(context,listen: false).setQuantiteCanette(i);
                                        }else{
                                          i=0;
                                          Provider.of<Cart>(context,listen: false).setQuantiteCanette(i);
                                        }

                                      },
                                    ),
                                  ),
                                ),
                                
                                Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(75, 174, 79,1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(
                                    onPressed: (){
                                      try{
                                
                                        if(_Allprice[index]['type_dechet']=='plastique'){
                                          Provider.of<Cart>(context,listen: false).addQuantitePlastique();
                                          var qte = int.parse(_quantitePlastiqueController.text.toString().trim())+ 10;
                                          setState(() {
                                            _quantitePlastiqueController.text =  qte.toString();
                                          });
                                        }
                                        if(_Allprice[index]['type_dechet']=='composte'){
                                          Provider.of<Cart>(context,listen: false).addQuantiteComposte(); 
                                          var qte = int.parse(_quantiteComposteController.text.toString().trim())+ 10;
                                          setState(() {
                                            _quantiteComposteController.text =  qte.toString();
                                          });
                                        }
                                        if(_Allprice[index]['type_dechet']=='papier'){
                                          Provider.of<Cart>(context,listen: false).addQuantitePapier();
                                          var qte = int.parse(_quantitePapierController.text.toString().trim())+ 10;
                                          setState(() {
                                            _quantitePapierController.text =  qte.toString();
                                          });
                                        }
                                        if(_Allprice[index]['type_dechet']=='canette'){ 
                                          Provider.of<Cart>(context,listen: false).addQuantiteCanette(); 
                                          var qte = int.parse(_quantiteCanetteController.text.toString().trim())+ 10;
                                          setState(() {
                                            _quantiteCanetteController.text =  qte.toString();
                                          });
                                        }         
                                      }catch(_){}
                                    },
                                    icon: const Icon(Icons.add, size: 17,)
                                  ),
                                ),
                              
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(75, 174, 79,1),
                                ),
                                onPressed: (){
                                  AchatModel achat = AchatModel.fromJson(_Allprice[index]);
                                  if(_Allprice[index]['type_dechet']=='plastique'){
                                    if(provider.quantitePlastique>0){
                                      Provider.of<Cart>(context,listen: false).add(achat,provider.quantitePlastique);
                                    }
                                  }
                                  if(_Allprice[index]['type_dechet']=='composte'){
                                    if(provider.quantiteComposte>0){
                                      Provider.of<Cart>(context,listen: false).add(achat,provider.quantiteComposte);
                                    }
                                  }
                                  if(_Allprice[index]['type_dechet']=='papier'){
                                    if(provider.quantitePapier>0){    
                                      Provider.of<Cart>(context,listen: false).add(achat,provider.quantitePapier);
                                    }
                                  }
                                  if(_Allprice[index]['type_dechet']=='canette'){
                                    if(provider.quantiteCanette>0){
                                      Provider.of<Cart>(context,listen: false).add(achat,provider.quantiteCanette);
                                    }
                                  }

                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child:Center(child: Text('Commander' ,)),
                                )),
                            ),
                            
                          ],
                        )
                      ),
                    );
                  }),
              ),
            ],
          ),
        )
      );
  }

  
}