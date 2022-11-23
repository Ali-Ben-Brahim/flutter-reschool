// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:estionnaire/gestionnaire/provider/ouvrier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifierOuvrier extends StatefulWidget {
  dynamic ouvrier;
  ModifierOuvrier({Key? key,this.ouvrier}) : super(key: key);
  @override
  State<ModifierOuvrier> createState() => _ModifierOuvrierState();
}

class _ModifierOuvrierState extends State<ModifierOuvrier> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _camionIdController =TextEditingController();
  final TextEditingController _postController =TextEditingController();
  final TextEditingController _nomController =TextEditingController();
  final TextEditingController _prenomController =TextEditingController();
  final TextEditingController _cinController =TextEditingController();
  final TextEditingController _numtelController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _adresseController =TextEditingController();
  @override
  void initState() {
    super.initState();
    _camionIdController.text = widget.ouvrier['camion_id'].toString();
    _postController.text = widget.ouvrier['poste'].toString();
    _nomController.text = widget.ouvrier['nom'].toString();
    _prenomController.text = widget.ouvrier['prenom'].toString();
    _cinController.text = widget.ouvrier['CIN'].toString();
    _numtelController.text = widget.ouvrier['numero_telephone'].toString();
    _emailController.text = widget.ouvrier['email'].toString();
    _adresseController.text = widget.ouvrier['adresse'].toString();
  }
  @override
  Widget build(BuildContext context) {
    bool load=Provider.of<OuvrierProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Modifier ouvrier'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Form(
          key:_formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                controller: _camionIdController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'camion id',
                  labelText: 'camion id *',
                  
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _postController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),),
                  filled: true,
                  hintText: 'poste',
                  labelText: 'poste *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _nomController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'nom',
                  labelText: 'nom *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _prenomController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'prenom',
                  labelText: 'prenom *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _cinController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'CIN',
                  labelText: 'CIN *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _numtelController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'numero telephone',
                  labelText: 'numero telephone *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _emailController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'email',
                  labelText: 'email *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _adresseController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'adresse',
                  labelText: 'adresse *',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              load? const Center(child: CircularProgressIndicator(),) :ElevatedButton(
                onPressed:(){
                  if(_formKey.currentState!.validate()){
                    dynamic data ={
                      'camion_id': _camionIdController.text,
                      'poste' : _postController.text,
                      'nom': _nomController.text,
                      'prenom':_prenomController.text,
                      'CIN':_cinController.text,
                      'adresse':_adresseController.text,
                      'numero_telephone':_numtelController.text,
                      'email':_emailController.text,
                    };
                    Provider.of<OuvrierProvider>(context,listen: false).updateOuvrier(widget.ouvrier['id'], data);

                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text('Modifier')),)
              )
            ],
          )
        ),
        
      ),
    );
  }
}