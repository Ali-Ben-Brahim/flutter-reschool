import 'package:estionnaire/gestionnaire/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  final TextEditingController _ancienmdpController = TextEditingController();
  final TextEditingController _nvmdpController = TextEditingController();
  final TextEditingController _cnvmdpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF196f3d),
          title:const Center(
            child:  Text("Changer mot de passe",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 24,
                )),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 200,
                ),
                TextFormField(
                  controller: _ancienmdpController,
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: const Text("Ancien mot de passe"),
          
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0)),
                    hintStyle: const TextStyle(fontSize: 16.0),
                    suffixIcon: IconButton(
                        icon: Icon(
          
                            _isObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                  }),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _nvmdpController,
                  obscureText: _isObscure1,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: const Text("Nouveau mot de passe"),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0)),
                    hintStyle: const TextStyle(fontSize: 16.0),
                    suffixIcon: IconButton(
                        icon: Icon(
          
                            _isObscure1 ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure1 = !_isObscure1;
                          });
                  }),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _cnvmdpController,
                  validator: (value){
                    if(value !=_nvmdpController.text){
                      return "incorrect";
                    }
                    return null;
                  },
                  obscureText: _isObscure2,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: const Text("Confirmer votre mot de passe"),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0)),
                    hintStyle: const TextStyle(fontSize: 16.0),
                    suffixIcon: IconButton(
                        icon: Icon(
          
                            _isObscure2 ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                  }),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
          
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      var creeds={
                        'mot_de_passe' : _ancienmdpController.text.trim(),
                        'newPassword' :  _nvmdpController.text.trim()
                      };
                      Provider.of<LoginProvider>(context,listen: false).updatePassword(creeds,context);
                    }
          
                  },
          
                  child: const Text('Confirmer'),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
