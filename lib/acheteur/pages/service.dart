import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/conversations_model.dart';
import '../provider/auth_provider.dart';
import '../provider/conversation_provider.dart';
import 'chat.dart';

class Service extends StatefulWidget {
  const Service({ Key? key }) : super(key: key);

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Réclamation'),
        backgroundColor: const Color.fromRGBO(75, 174, 79,1),
      ),
      body:InkWell(
        onTap: ()async{
          dynamic token =Provider.of<AuthProvider>(context,listen: false).tokens;
          
          var conversations=await Provider.of<ConversationProvider>(context,listen: false).addConversation(token);
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Chat(conversation: ConversationModel.fromJson(conversations))));
        },
        child: 
          ListView(
              padding: const EdgeInsets.fromLTRB(20 , 35 , 20 ,0),
              children: const[
                SizedBox(
                  height: 250,
                  child: Image(
                    image: AssetImage('image/service.png'),),
                ),
                Center(child: Text("Messages",style:TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold) ,))
                
              ],
            ),
      ),
    );
  }
}