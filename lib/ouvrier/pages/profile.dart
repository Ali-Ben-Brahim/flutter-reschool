
import 'dart:convert';

import 'package:estionnaire/gestionnaire/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/url_db.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
    late XFile? _imagefile;
    File? _image;
    final ImagePicker picker = ImagePicker();


    upload(){
      if(_image ==null){
        return;
      }
      String base64= base64Encode(_image!.readAsBytesSync());

    }
  @override
  Widget build(BuildContext context) {
    void takePhoto(ImageSource source)async{
      _imagefile =null;
      _imagefile =await picker.pickImage(
        source:source,
      );
      Provider.of<LoginProvider>(context,listen: false).updateImage(_image);
      setState(() {
        _image = File(_imagefile!.path);
      });
      print("_imagefile ${_imagefile!.path.split('/').last}");
      upload();
    }

    Widget bottomSheet(){
      return Container(
        height:150.0,
        width:MediaQuery.of(context).size.width,
        margin:const EdgeInsets.symmetric(
          horizontal:20,
          vertical:20,
        ),
        child:Column(
          children:<Widget>[
            const Text(
              "Choisir photo de profile",
              style:TextStyle(
                fontSize:29.8,
              ),// Textstyle
            ),// Text
            const SizedBox(
              height:20,
            ),// SizedBox
            Row(mainAxisAlignment:MainAxisAlignment.center,children:<Widget>[
              ElevatedButton.icon(
                icon:const Icon(Icons.camera),
                onPressed:(){
                  takePhoto(ImageSource.camera);
                },
                label:const Text("Camera"),
              ),// FlatButton.icon
              Expanded(child: Container()),
              ElevatedButton.icon(
                icon:const Icon(Icons.image),
                onPressed:(){
                  takePhoto(ImageSource.gallery);
                },
                label:const Text("Gallery"),
              ),
            ])
          ],
        ),
      );
    }
    

    final TextEditingController nom = TextEditingController();
    final TextEditingController prenom = TextEditingController();
    final TextEditingController cin = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController NumeroTel = TextEditingController();
    final formKey = GlobalKey<FormState>();
  
  nom.text = Provider.of<LoginProvider>(context,listen: true).nom;
  prenom.text = Provider.of<LoginProvider>(context,listen: true).prenon;

  cin.text = Provider.of<LoginProvider>(context,listen: true).cin;
  email.text = Provider.of<LoginProvider>(context,listen: true).email;
  NumeroTel.text = Provider.of<LoginProvider>(context,listen: true).tel;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF196f3d),
          title: const Center(
            child: Text("Mes informations",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                )),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageuser(Provider.of<LoginProvider>(context,listen: true).photo),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(context: context, builder: (builder){
                          return bottomSheet();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), backgroundColor: Colors.green,
                        fixedSize: const Size(120, 30),
                      ),
                      child: const Text("Changer photo"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(Provider.of<LoginProvider>(context,listen: true).photo!=null ){
                          if(Provider.of<LoginProvider>(context,listen: true).photo!='null'){
                            Provider.of<LoginProvider>(context,listen: false).supprimerImage();
                            setState(() {});
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        fixedSize: const Size(120, 30),
                      ),
                      child: const Text("Supprimer image"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller:nom,
                      validator: (value)=> value!.isNotEmpty?null:'champs obligatoire',
                      decoration: InputDecoration(
                        label: const Text("Nom"),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0)),
                        hintStyle: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller:prenom,
                      validator: (value)=> value!.isNotEmpty?null:'champs obligatoire',
                      decoration: InputDecoration(
                        label: const Text("prénom"),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0)),
                        hintStyle: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller:cin,
                      validator: (value)=> value!.isNotEmpty?null:'champs obligatoire',
                      decoration: InputDecoration(
                        
                        label: const Text("CIN"),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0)),
                        hintStyle: const TextStyle(fontSize: 16.0),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller:email,
                      validator: (value)=> value!.isNotEmpty?null:'champs obligatoire',
                      decoration: InputDecoration(
                        label: const Text("E-mail"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.black, width: 2.0)
                        ),
                        hintStyle: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: NumeroTel,
                      validator: (value)=> value!.isNotEmpty?null:'champs obligatoire',
                      decoration: InputDecoration(
                        label: const Text("Numéro de téléphone"),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0)),
                        hintStyle: const TextStyle(fontSize: 16.0),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                  
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          var creeds ={
                            'nom' : nom.text.trim(),
                            'prenom' : prenom.text.trim(),
                            'CIN' : cin.text.trim(),
                            'email' : email.text.trim(),
                            'numero_telephone' : NumeroTel.text.trim(),
                          };
                          Provider.of<LoginProvider>(context,listen: false).update(creeds, context);
                        }
                      },
                  
                      child: const Text('Valider'), // <-- Text
                    ),
                  ],
                ),
              ),
            )
          ),
      ),
    );
  }
}


Widget imageuser(photo){
  if(photo!=null ){
    if(photo!='null'){
      
      return ClipOval(
        child: Image.network('$baseURL/storage/images/ouvrier/$photo',fit: BoxFit.cover,));
      
    }
  }
  return  const CircleAvatar(
    radius: 120,
    backgroundImage: AssetImage("assets/images/user.png"));
}

