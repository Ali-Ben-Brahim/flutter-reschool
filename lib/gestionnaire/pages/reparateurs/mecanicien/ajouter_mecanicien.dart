
import 'package:estionnaire/gestionnaire/provider/reparateurs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjouterMecanicien extends StatefulWidget {
  const AjouterMecanicien({Key? key}) : super(key: key);

  @override
  State<AjouterMecanicien> createState() => _AjouterMecanicienState();
}

class _AjouterMecanicienState extends State<AjouterMecanicien> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController =TextEditingController();
  final TextEditingController _prenomController =TextEditingController();
  final TextEditingController _cinController =TextEditingController();
  final TextEditingController _numtelController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _adresseController =TextEditingController();
  final TextEditingController _mdpController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool load=Provider.of<ReparateursProvider>(context).isloading;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Ajouter mecanicien'),
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
                      'nom': _nomController.text,
                      'prenom':_prenomController.text,
                      'CIN':_cinController.text,
                      'adresse':_adresseController.text,
                      'numero_telephone':_numtelController.text,
                      'email':_emailController.text,
                      'mot_de_passe':_mdpController.text
                    };
                    Provider.of<ReparateursProvider>(context,listen: false).ajouterMecanicien(data);

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