// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:estionnaire/gestionnaire/provider/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifierClient extends StatefulWidget {
  dynamic client;
  ModifierClient({Key? key,this.client}) : super(key: key);
  @override
  State<ModifierClient> createState() => _ModifierClientState();
}

class _ModifierClientState extends State<ModifierClient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomEntrepriseController =TextEditingController();
  final TextEditingController _matriculeFiscaleController =TextEditingController();
  final TextEditingController _nomResponsableController =TextEditingController();
  final TextEditingController _numeroFixeController =TextEditingController();
  final TextEditingController _numeroTelephoneController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _adresseController =TextEditingController();
  @override
  void initState() {
    super.initState();
    _nomEntrepriseController.text = widget.client['nom_entreprise'].toString();
    _matriculeFiscaleController.text = widget.client['matricule_fiscale'].toString();
    _nomEntrepriseController.text = widget.client['nom_responsable'].toString();
    _numeroFixeController.text = widget.client['numero_fixe'].toString();
    _numeroTelephoneController.text = widget.client['numero_telephone'].toString();
    _emailController.text = widget.client['email'].toString();
    _adresseController.text = widget.client['adresse'].toString();
  }
  @override
  Widget build(BuildContext context) {
    bool load=Provider.of<ClientProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Modifier client'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Form(
          key:_formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                controller: _nomEntrepriseController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'Nom Entreprise',
                  labelText: 'Nom Entreprise *',
                  
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _matriculeFiscaleController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),),
                  filled: true,
                  hintText: 'Matricule fiscale',
                  labelText: 'Matricule fiscale *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _nomResponsableController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'Nom responsable',
                  labelText: 'Nom responsable *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _numeroFixeController,
                validator: (value)=>value!.isEmpty?'Champs obligatoire':null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'Numero fixe',
                  labelText: 'Numero fixe *',
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _numeroTelephoneController,
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
                      'nom_entreprise': _nomEntrepriseController.text,
                      'matricule_fiscale' : _matriculeFiscaleController.text,
                      'nom_responsable': _nomResponsableController.text,
                      'numero_fixe':_numeroFixeController.text,
                      'numero_telephone':_numeroTelephoneController.text,
                      'adresse':_adresseController.text,
                      'email':_emailController.text,
                    };
                    Provider.of<ClientProvider>(context,listen: false).updateClient(widget.client['id'], data);

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