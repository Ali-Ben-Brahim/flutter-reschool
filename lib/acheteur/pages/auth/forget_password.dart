import 'package:estionnaire/acheteur/services/url_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({ Key? key }) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
    
  }
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  
  Future <void> forgetPassword() async{
    try{
      http.Response response = await http.post(Uri.parse(forgetPasswordURL) ,
      body: {
        'email' : _emailController.text
      });
      if(response.statusCode ==200){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 58, 250, 0),
            content: Text('Un message est envoye a votre mail '),
        ));
        Get.offAllNamed("/Login");
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('addresse mail incorrecte'),
      ));
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error server'),
      ));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
        centerTitle: true,
        title: const Text('oublier mot de passe'),),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
              child : Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding:  const EdgeInsets.fromLTRB(30 ,30 ,30 , 10),
                      child: TextFormField(
                      controller: _emailController,
                      validator: (value)=>value!.isNotEmpty? null : 'Please enter your email',
                        decoration:  InputDecoration(
                          label: const Text("E-mail"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black38,
                              width: 2,
                            )
                          ),
                          prefixIcon: const Icon(Icons.account_circle),
                        ),
                        textInputAction: TextInputAction.next,

                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      padding:  const EdgeInsets.fromLTRB(30 ,0 ,30 , 10),
                      child:ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:MaterialStateProperty.all(const Color.fromRGBO(75, 174, 79,1)),
                        ),
                        onPressed:() {
                          if(_formKey.currentState!.validate()){
                            if(mounted){
                              forgetPassword();
                            }
                          }
                        },
                        child: const Text('envoyer un message de verification'),
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