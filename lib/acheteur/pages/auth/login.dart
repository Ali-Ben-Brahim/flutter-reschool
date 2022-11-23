import '/acheteur/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';


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
  ApiResponse response =ApiResponse();
  String qrData ='';
  Future _scan() async {
    try {
    await FlutterBarcodeScanner.scanBarcode(
      "#000000", "cancel", true, ScanMode.BARCODE)
      .then((value) {
        if(mounted){
          setState(() {
             qrData = value.substring(7);
          });
        } 
      });
      Provider.of<AuthProvider>(context , listen: false).loginqr(qrData , context);
    }catch(e){
      print('ADMIN ERROR : \n $e');
    }
    
  }
  

  @override
  void initState() {
    _emailController.text = 'amine@gmail.com';
    _passwordController.text = 'amine1234' ;
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      bool nav = await Provider.of<AuthProvider>(context , listen: false).getUser();
      if(nav){
        Get.offAllNamed('/Accueil');
      }
    });
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
        
        body:
        Provider.of<AuthProvider>(context , listen: true).busy? const Center(child: CircularProgressIndicator()):
         Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
              child : Form(
                key:_formKey ,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: SizedBox(
                        height: 120,
                        child: Image.asset(
                          "image/reschool.png"),
                      ),
                    ),
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
                            "device_name" : "mobile"
                            };
                          Provider.of<AuthProvider>(context , listen: false).login(creeds ,context);                    
                          }
                        },
                        child: const Text('connecter'),
                        )
                    ),
                    Container(
                      width: double.infinity,
                      padding:  const EdgeInsets.fromLTRB(30 ,0 ,30 , 10),
                      child:ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              side: const BorderSide(
                                width: 1,
                                color: Colors.black
                              )
                            )
                          ),
                      backgroundColor:MaterialStateProperty.all(Colors.white),
                      fixedSize: MaterialStateProperty.all(const Size(349, 48)),
                      textStyle:MaterialStateProperty.all(const TextStyle(fontSize: 16))),
                        onPressed: (){
                          Get.toNamed("/ForgetPassword");
                        },
                       child: const Text("mot de passe oublier" , 
                        style: TextStyle(
                          color: Color.fromRGBO(75, 174, 79,1)
                            ),
                          ),
                       ),
                    ),
                    
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Divider(
                        thickness: 2,
                      ),
                    ),
                    const Text("ou connecter avec QR"),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: const Icon(
                        Icons.qr_code_scanner,
                          size: 72,
                        ),
                      ),
                      onTap: () => _scan(),
                    ),
                  ],   
              ),
            )
          ),
        ),
    );
  }
}