
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';



class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  
  
  final bool _isconnected = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  

  @override
  void initState() {
    _emailController.text = 'ouvrier1.reschool@gmail.com';
    _passwordController.text = 'ouvrier1';
    super.initState();
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body:Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
              child : Form(
                key:_formKey ,
                child: Column(
                  children: [
                    //phrase connecter vous ...
                    const Padding(
                      padding:  EdgeInsets.fromLTRB(30 ,0 ,30 , 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Connectez vous à votre compte",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                    // Email
                    Container(
                      padding:  const EdgeInsets.fromLTRB(30 ,30 ,30 , 10),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value)=> value!.isEmpty? 'veuillez saisir votre email' :null,
                        decoration:  InputDecoration(
                          label: const Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black38,
                              width: 2,
                            )
                          ),
                          prefixIcon: const Icon(Icons.account_circle_outlined),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    //mot de passe
                    Container(
                      padding:  const EdgeInsets.fromLTRB(30 ,10 ,30 , 10),
                      child: TextFormField(
                        obscureText: true,
                       controller: _passwordController,
                        validator: (value)=> value!.isEmpty? 'veuillez saisir votre mot de passe' :null,
                        decoration:  InputDecoration(
                          label: const Text("mot de passe"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black38,
                              width: 2,
                            )
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        textInputAction: TextInputAction.go,
                      ),
                    ),
                    
                    
                    
                    Container(
                      width: double.infinity,
                      padding:  const EdgeInsets.fromLTRB(30 ,0 ,30 , 10),
                      child:ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0),
                            )
                          ),
                      backgroundColor:MaterialStateProperty.all(const Color.fromRGBO(75, 174, 79,1)),
                      fixedSize: MaterialStateProperty.all(const Size(349, 48)),
                      textStyle:MaterialStateProperty.all(const TextStyle(fontSize: 16))),
                        onPressed:() {
                          if(_formKey.currentState!.validate()){
                            Map creeds = {
                            'email' : _emailController.text.trim(),
                            'mot_de_passe' : _passwordController.text.trim(),
                            "recaptcha" : "1"
                            };
                          Provider.of<LoginProvider>(context , listen: false).login(creeds,context);                    
                          }
                        },
                        child: const Text('connecter'),
                        )
                    ),
                    
                  ],   
              ),
            )
          ),
        ),
    );
  }
}