// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/reparateurs_provider.dart';

class ModifierMecanicien extends StatefulWidget {
  dynamic mecanicien;
  ModifierMecanicien({Key? key,this.mecanicien}) : super(key: key);
  @override
  State<ModifierMecanicien> createState() => _ModifierMecanicienState();
}

class _ModifierMecanicienState extends State<ModifierMecanicien> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController =TextEditingController();
  final TextEditingController _prenomController =TextEditingController();
  final TextEditingController _cinController =TextEditingController();
  final TextEditingController _numtelController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _adresseController =TextEditingController();
  @override
  void initState() {
    super.initState();
    _nomController.text = widget.mecanicien['nom'].toString();
    _prenomController.text = widget.mecanicien['prenom'].toString();
    _cinController.text = widget.mecanicien['CIN'].toString();
    _numtelController.text = widget.mecanicien['numero_telephone'].toString();
    _emailController.text = widget.mecanicien['email'].toString();
    _adresseController.text = widget.mecanicien['adresse'].toString();
  }
  @override
  Widget build(BuildContext context) {
    bool load=Provider.of<ReparateursProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Modifier mecanicien'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Form(
          key:_formKey,
          child: ListView(
            children: [
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
                      'nom': _nomController.text,
                      'prenom':_prenomController.text,
                      'CIN':_cinController.text,
                      'adresse':_adresseController.text,
                      'numero_telephone':_numtelController.text,
                      'email':_emailController.text,
                    };
                    Provider.of<ReparateursProvider>(context,listen: false).updateMecanicien(widget.mecanicien['id'], data);

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