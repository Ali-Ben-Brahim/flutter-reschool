
import 'package:estionnaire/gestionnaire/provider/responsable_etablissement_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjouterRespnsable extends StatefulWidget {
  const AjouterRespnsable({Key? key}) : super(key: key);

  @override
  State<AjouterRespnsable> createState() => _AjouterRespnsableState();
}

class _AjouterRespnsableState extends State<AjouterRespnsable> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController =TextEditingController();
  final TextEditingController _prenomController =TextEditingController();
  final TextEditingController _numeroFixeController =TextEditingController();
  final TextEditingController _numtelController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _adresseController =TextEditingController();
  final TextEditingController _mdpController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Ajouter responsable etablissment'),
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
                validator: (value)=>value!.isEmpty? 'champs obligatoire':null,
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
                validator: (value)=>value!.isEmpty? 'champs obligatoire':null,
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
                controller: _numeroFixeController,
                validator: (value)=>value!.isEmpty? 'champs obligatoire':null,
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
                controller: _numtelController,
                validator: (value)=>value!.isEmpty? 'champs obligatoire':null,
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
                validator: (value)=>value!.isEmpty? 'champs obligatoire':null,
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
                validator: (value)=>value!.isEmpty? 'champs obligatoire':null,
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
                validator: (value)=>value!.isEmpty? 'champs obligatoire':null,
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
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    dynamic data ={
                      'nom': _nomController.text,
                      'prenom':_prenomController.text,
                      'adresse':_adresseController.text,
                      'numero_telephone':_numtelController.text,
                      'numero_fixe':_numeroFixeController.text,
                      'email':_emailController.text,
                      'mot_de_passe': _mdpController.text
                    };
                    Provider.of<ResponsableEtablissmentProvider>(context,listen: false).ajouterResponsable(data);
                    
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