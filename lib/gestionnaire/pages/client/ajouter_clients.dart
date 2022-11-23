// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:estionnaire/gestionnaire/provider/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjouterClient extends StatefulWidget {
  const AjouterClient({Key? key}) : super(key: key);
  @override
  State<AjouterClient> createState() => _AjouterClientState();
}

class _AjouterClientState extends State<AjouterClient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomEntrepriseController =TextEditingController();
  final TextEditingController _matriculeFiscaleController =TextEditingController();
  final TextEditingController _nomResponsableController =TextEditingController();
  final TextEditingController _numeroFixeController =TextEditingController();
  final TextEditingController _numeroTelephoneController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _adresseController =TextEditingController();
  final TextEditingController _mdpController =TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    bool load=Provider.of<ClientProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Ajouter client'),
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
              const SizedBox(height: 20,),
              TextFormField(
                controller: _mdpController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'mot de passe',
                  labelText: 'mot de passe *',
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
                      'mot_de_passe':_mdpController.text
                    };
                    Provider.of<ClientProvider>(context,listen: false).ajouterClient(data);
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text('Ajouter')),)
              )
            ],
          )
        ),
        
      ),
    );
  }
}