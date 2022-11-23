import '../provider/conversation_provider.dart';
import 'package:get_it/get_it.dart';

import '../pages/accueil.dart';
import 'auth_provider.dart';
import 'cart_provider.dart';


GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerFactory(() => AuthProvider());
  locator.registerLazySingleton(() => Cart());
  locator.registerLazySingleton(() => Accueil());
  locator.registerLazySingleton(() => ConversationProvider());
}