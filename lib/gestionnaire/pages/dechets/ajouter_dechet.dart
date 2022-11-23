
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/dechets_provider.dart';

class AjouterDechet extends StatefulWidget {
  const AjouterDechet({Key? key,}) : super(key: key);

  @override
  State<AjouterDechet> createState() => _AjouterDechetState();
}

class _AjouterDechetState extends State<AjouterDechet> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeDechetController =TextEditingController();
  final TextEditingController _prixUnitaireController =TextEditingController();
  final TextEditingController _pourcentageRemiseController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20,),
                TextFormField(
                  controller: _typeDechetController,
                  validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    hintText: 'Type dechet',
                    labelText: 'Type dechet *',
                    
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _prixUnitaireController,
                  validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    hintText: 'Prix unitaire',
                    labelText: 'Prix unitaire *',
                    
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _pourcentageRemiseController,
                  validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    hintText: 'Pourcentage remise',
                    labelText: 'Pourcentage remise *',
                    
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green
                  ),
                  onPressed: (){
                      if(_formKey.currentState!.validate()){
                      dynamic data ={
                        'type_dechet': _typeDechetController.text,
                        'prix_unitaire' : _prixUnitaireController.text,
                        'pourcentage_remise': _pourcentageRemiseController.text,
                      };
                      Provider.of<DechetsProvider>(context,listen: false).ajouterDechets(data);
                    }
                  },
                  child:const SizedBox(
                    width: double.infinity,
                    child: Center(child: Text('Ajouter')),
                  ) 
                )
            ],
          ),
        ),
      ),
    );
  }
}