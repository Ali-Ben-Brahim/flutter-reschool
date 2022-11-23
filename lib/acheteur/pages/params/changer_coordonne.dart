
import 'package:estionnaire/acheteur/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../models/user_model.dart';




class ChangerCoordonne extends StatefulWidget {
  const ChangerCoordonne({ Key? key }) : super(key: key);

  @override
  _ChangercoordCnneState createState() => _ChangercoordCnneState();
}

class _ChangercoordCnneState extends State<ChangerCoordonne> {
  String? nom_entreprise;
  String? matricule_fiscale;
  String? nom_responsable;
  String? numero_fixe;
  String? adresse;
  String? numero_telephone;
  String? email;
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nom_entrepriseController = TextEditingController();
  final TextEditingController _matricule_fiscaleController = TextEditingController();
  final TextEditingController _nom_responsableController = TextEditingController();
  final TextEditingController _numero_fixeController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _numero_telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int? _id ;
 

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<AuthProvider>(context,listen: true).user;
    _id = user!.id!;
    _nom_entrepriseController.text = user.nom_entreprise!; 
    _matricule_fiscaleController.text = user.matricule_fiscale!;
    _nom_responsableController.text = user.nom_responsable!; 
    _numero_fixeController.text = user.numero_fixe!; 
    _adresseController.text = user.adresse!; 
    _numero_telephoneController.text = user.numero_telephone!; 
    _emailController.text = user.email!; 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mes informations'),
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child : Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("nom de l'entreprise : ",style: TextStyle(fontWeight: FontWeight.bold),)),
                  const SizedBox(height:10),
                //nom de l'entreprise
                TextFormField(
                  controller: _nom_entrepriseController,
                  decoration:  InputDecoration(
                    label: const Text(" nom de l'entreprise"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 2,
                      )
                    ),
                    prefixIcon: const Icon(Icons.abc),
                  ),
                  validator: (value)=> value!.isEmpty ? ' veuillez saisir votre nom de l\'entreprise' : null, 
                  ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("nom de responsable : ",style: TextStyle(fontWeight: FontWeight.bold),)),
                  const SizedBox(height:10),
                // nom de responsable
                TextFormField(
                  controller: _nom_responsableController,
                  decoration:  InputDecoration(
                    label: const Text(" nom de responsable "),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 2,
                      )
                    ),
                    prefixIcon: const Icon(Icons.abc),
                  ),
                  validator: (value)=> value!.isEmpty ? ' veuillez saisir votre nom ' : null, 
                  ),
                const SizedBox(
                  height: 20,
                ),
               const Align(
                  alignment: Alignment.topLeft,
                  child: Text("E-mail : ",style: TextStyle(fontWeight: FontWeight.bold),)),
                  const SizedBox(height:10),
                //E-mail
                TextFormField(
                  controller: _emailController,
                  
                  decoration:  InputDecoration(
                    label: const Text(" E-mail "),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 2,
                      )
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value){
                    if (value!.isEmpty) {
                        return ' veuillez saisir votre adresse Email ';
                    }
                    if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
                      return ' veuillez saisir votre adresse Email ';
                    }
                    return null;
                  },
                  
                ),
                
                
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("numero fixe : ",style: TextStyle(fontWeight: FontWeight.bold),)),
                  const SizedBox(height:10),
                //numero fixe
               TextFormField(
                  controller: _numero_fixeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration:  InputDecoration(
                    label: const Text(" numero fixe "),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 2,
                      )
                    ),
                    prefixIcon: const Icon(Icons.credit_card_sharp),
                  ),
                  validator: (value)=> value!.isEmpty ? 
                  ' veuillez saisir votre numero fixe' : value.length !=8 ?
                   ' veuillez saisir 8 chiffres ':null, 
                ),
              
               
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("numero de telephone : ",style: TextStyle(fontWeight: FontWeight.bold),)),
                  const SizedBox(height:10),
                // numero de telephone
                TextFormField(
                  controller: _numero_telephoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration:  InputDecoration(
                    label: const Text(" numéro de telephone"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 2,
                      )
                    ),
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  validator: (value)=> value!.isEmpty ? ' veuillez saisir votre numéro de telephone ' : value.length !=8 ? ' veuillez saisir 8 chiffres ':null, 
                ),
                
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("matricule fiscale : ",style: TextStyle(fontWeight: FontWeight.bold),)),
                  const SizedBox(height:10),
                // matricule fiscale
                TextFormField(
                controller: _matricule_fiscaleController,
                decoration:  InputDecoration(
                  label: const Text(" matricule fiscale "),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black38,
                      width: 2,
                    )
                  ),
                  prefixIcon: const Icon(Icons.abc),
                ),
                validator: (value)=> value!.isEmpty ? ' veuillez saisir votre matricule fiscale ' : null, 
                ),

                const SizedBox(
                  height: 20,
                ),
            
                Container(
                  padding: const EdgeInsets.fromLTRB(0 , 15 , 0 ,0),
                  width: double.infinity,
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(75, 174, 79,1),
                    ),
                    onPressed:() async{
                      if(_formKey.currentState!.validate()){
                        Map data ={
                          'nom_entreprise' : _nom_entrepriseController.text.trim() ,
                          'matricule_fiscale' : _matricule_fiscaleController.text.trim(), 
                          'nom_responsable' : _nom_responsableController.text.trim() ,
                          'adresse' : _adresseController.text.trim(), 
                          'email' : _emailController.text.trim() ,
                          'numero_fixe' : _numero_fixeController.text.trim(), 
                          'numero_telephone' : _numero_telephoneController.text.trim(), 
                        };
                        await Provider.of<AuthProvider>(context, listen: false).update(_id, data ,context);
                      }
                    },
                    child: const Text('Valider'),
                    )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}