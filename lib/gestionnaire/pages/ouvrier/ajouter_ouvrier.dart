
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/ouvrier_provider.dart';

class AjouterOuvrier extends StatefulWidget {
  const AjouterOuvrier({Key? key}) : super(key: key);

  @override
  State<AjouterOuvrier> createState() => _AjouterOuvrierState();
}

class _AjouterOuvrierState extends State<AjouterOuvrier> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _camionIdController =TextEditingController();
  final TextEditingController _postController =TextEditingController();
  final TextEditingController _nomController =TextEditingController();
  final TextEditingController _prenomController =TextEditingController();
  final TextEditingController _cinController =TextEditingController();
  final TextEditingController _numtelController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _adresseController =TextEditingController();
  final TextEditingController _mdpController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool load=Provider.of<OuvrierProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Ajouter ouvrier'),
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
                onPressed: (){
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
                      'mot_de_passe':_mdpController.text
                    };
                    Provider.of<OuvrierProvider>(context,listen: false).ajouterOuvrier(data);

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