
import 'package:estionnaire/acheteur/pages/accueil.dart';

import '../acheteur/pages/auth/forget_password.dart';
import '../acheteur/pages/auth/login.dart';
import '../acheteur/pages/panier.dart';
import '../acheteur/pages/params/a_propos.dart';
import '../acheteur/pages/params/changer_mot_de_passe.dart';
import '../acheteur/pages/params/changer_coordonne.dart';
import '../acheteur/pages/params/notifications.dart';
import '../acheteur/provider/auth_provider.dart';
import '../acheteur/provider/cart_provider.dart';
import '../acheteur/provider/conversation_provider.dart';
import '../acheteur/provider/locator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<ConversationProvider>()),
        ChangeNotifierProvider(create: (_) => locator<AuthProvider>()),
      ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => AuthProvider()),),
        ChangeNotifierProvider(create: ((context) => Cart()),),
        
      ],
      child: GetMaterialApp( 
        debugShowCheckedModeBanner: false,
        home: const Login(),  
        getPages :[
          GetPage(name: "/Login", page:()=>const Login()),
          GetPage(name: "/Accueil", page:()=> Accueil()),
          GetPage(name: "/ForgetPassword", page:()=>const ForgetPassword()),
          GetPage(name: "/ChangerCoordonne", page: ()=> const ChangerCoordonne()),
          GetPage(name: "/Notification", page: ()=>  const Notif()),
          GetPage(name: "/ChangerMotDePasse", page: ()=>  const ChangerMotDePasse()),
          GetPage(name: "/Panier", page: ()=>   const Panier()),
          GetPage(name: "/Apropos", page: ()=>  const Apropos()),
        ]
    ),
    );
  }
}
