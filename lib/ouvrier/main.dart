import 'package:estionnaire/ouvrier/pages/signup.dart';
import 'package:estionnaire/ouvrier/provider/conversation_provider.dart';
import 'package:estionnaire/ouvrier/provider/locator.dart';
import 'package:estionnaire/ouvrier/services/user_service.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'provider/auth_provider.dart';

void main() {
  setupLocator();
  return runApp(
    MultiProvider(
      providers: [
        //recherche ChangeNotifierProvider sans <ConversationProvider>
       ChangeNotifierProvider(create: (_) => locator<ConversationProvider>()),
        ChangeNotifierProvider(create: (_) => locator<AuthProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return Auth();
        },
        child: const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reschool',
          home: Login(),
        ));
  }
}
