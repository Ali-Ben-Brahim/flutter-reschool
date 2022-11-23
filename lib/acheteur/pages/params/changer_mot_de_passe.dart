
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class ChangerMotDePasse extends StatefulWidget {
  const ChangerMotDePasse({ Key? key }) : super(key: key);

  @override
  _ChangerMotDePasseState createState() => _ChangerMotDePasseState();
}

class _ChangerMotDePasseState extends State<ChangerMotDePasse> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  dynamic _email;
  password(){
    return TextFormField(       
      controller: _passwordController,  
      validator: (value)=>value!.isEmpty? 'please enter your password':null,    
      decoration:  InputDecoration(
        label: const Text("ancien mot de passe"),
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
    );
  }
  newPassword(){
    return TextFormField(   
      controller: _newPasswordController,   
      validator: (value)=>value!.isEmpty? 'please enter your new password':null,          
      decoration:  InputDecoration(
        label: const Text("nouveau mot de passe"),
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
    );
  }
  myButton(){
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        _email = auth.user!.email;
        return Container(
        padding: const EdgeInsets.fromLTRB(0 , 15 , 0 ,0),
        width: double.infinity,
        child:ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(75, 174, 79,1),
          ),
          onPressed:() {
            if(_formKey.currentState!.validate()){
              Map creeds = {'mot_de_passe' :_passwordController.text.trim() , 'newPassword' :_newPasswordController.text.trim()};
              Provider.of<AuthProvider>(context , listen: false).updatePassword(_email, creeds, context);
            }
          },
          child: const Text('Confirmer'),
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Changer mot de passe'),
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                password(),
                const SizedBox(
                    height: 30,
                  ),
                newPassword(),const SizedBox(
                    height: 20,
                  ),
                myButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}