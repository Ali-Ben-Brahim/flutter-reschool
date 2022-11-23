
// ignore_for_file: must_be_immutable

import 'package:estionnaire/gestionnaire/provider/dechets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifierDechet extends StatefulWidget {
  dynamic dechets;
  ModifierDechet({Key? key,this.dechets}) : super(key: key);

  @override
  State<ModifierDechet> createState() => _ModifierDechetState();
}

class _ModifierDechetState extends State<ModifierDechet> {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _typeDechetController =TextEditingController();
    final TextEditingController _prixUnitaireController =TextEditingController();
    final TextEditingController _pourcentageRemiseController =TextEditingController();

  @override
    void initState() {
      super.initState();
      _typeDechetController.text = widget.dechets['type_dechet'].toString();
      _prixUnitaireController.text = widget.dechets['prix_unitaire'].toString();
      _pourcentageRemiseController.text = widget.dechets['pourcentage_remise'].toString();
    }
  @override
  Widget build(BuildContext context) {
    bool load = Provider.of<DechetsProvider>(context).isLoading;
    return Scaffold(
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
              load? const Center(child: CircularProgressIndicator(),) :
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
                    Provider.of<DechetsProvider>(context,listen: false).updateDechets(widget.dechets['id'], data);

                  }
                },
                child:const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text('Modifier')),
                ) 
              )
            ],
          ),
        ),
      ),
    );
  }
}