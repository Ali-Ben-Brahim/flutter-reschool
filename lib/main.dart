import 'package:estionnaire/acheteur/provider/auth_provider.dart';
import 'package:estionnaire/acheteur/provider/collect_class.dart';
import 'package:estionnaire/gestionnaire/pages/login.dart';
import 'package:estionnaire/gestionnaire/provider/client_provider.dart';
import 'package:estionnaire/gestionnaire/provider/dashboard_provider.dart';
import 'package:estionnaire/gestionnaire/provider/dechets_provider.dart';
import 'package:estionnaire/gestionnaire/provider/login_provider.dart';
import 'package:estionnaire/gestionnaire/provider/ouvrier_provider.dart';
import 'package:estionnaire/gestionnaire/provider/reparateurs_provider.dart';
import 'package:estionnaire/gestionnaire/provider/responsable_etablissement_provider.dart';
import 'package:estionnaire/ouvrier/provider/conversation_provider.dart';
import 'package:estionnaire/ouvrier/provider/etab_class.dart';
import 'package:estionnaire/ouvrier/provider/locator.dart';
import 'package:estionnaire/ouvrier/provider/table_class.dart';
import 'package:estionnaire/provider/standard_provider.dart';
import 'package:estionnaire/responsable_etablissment/provider/planning_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'acheteur/provider/cart_provider.dart';
import 'responsable_etablissment/provider/data_class.dart';
import 'responsable_etablissment/provider/etablssment_data_class.dart';
import 'responsable_etablissment/provider/trie_class.dart';



void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => OuvrierProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => ResponsableEtablissmentProvider()),
        ChangeNotifierProvider(create: (_) => DechetsProvider()),
        ChangeNotifierProvider(create: (_) => ReparateursProvider()),
        ChangeNotifierProvider(create: (_) => EtablissementDataClass()),
        ChangeNotifierProvider(create: (_) => TrieClass()),
        ChangeNotifierProvider(create: (_) => StandarProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_)=>DataClass()),
        ChangeNotifierProvider(create: (_)=>EtabClass()),
        ChangeNotifierProvider(create: (_)=>TableClass()),
        ChangeNotifierProvider(create: (_)=>CollectClass()),
        ChangeNotifierProvider(create: (_)=>PlanningClass()),
        ChangeNotifierProvider(create: (_) => locator<ConversationProvider>()),
        ChangeNotifierProvider(create: ((context) => AuthProvider()),),
        ChangeNotifierProvider(create: ((context) => Cart()),),
      ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
         localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            SfGlobalLocalizations.delegate
        ],
        supportedLocales: const [
            Locale('fr'),
            Locale('ar'),
            Locale('ja'),
        ],
        locale: const Locale('fr'),
      
      title: 'RE::SCHOOL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const Login()
    );
  }
}

