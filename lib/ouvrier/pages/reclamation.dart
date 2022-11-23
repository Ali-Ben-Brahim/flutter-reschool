import 'package:estionnaire/gestionnaire/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/conversations_model.dart';
import '../provider/conversation_provider.dart';
import '../services/user_service.dart';
import 'chat.dart';

class Signaler extends StatefulWidget {
  const Signaler({Key? key}) : super(key: key);

  @override
  State<Signaler> createState() => _SignalerState();
}

class _SignalerState extends State<Signaler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Réclamation'),
        backgroundColor: const Color.fromRGBO(75, 174, 79, 1),
      ),
      body: InkWell(
        onTap: () async {
         

          var conversations =
              await Provider.of<ConversationProvider>(context, listen: false)
                  .addConversation(Provider.of<LoginProvider>(context, listen: false).tokenuser);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Chat(
                      conversation:
                          ConversationModel.fromJson(conversations))));
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
          children:  [
            SizedBox(
              height: 250,
              child: Image.asset('assets/images/reclamation.png'),
              
            ),
            const Center(
                child: Text(
              "Messages",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }
}
