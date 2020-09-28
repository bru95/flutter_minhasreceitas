import 'package:get_it/get_it.dart';
import 'package:minhasreceitas/services/firebase_service.dart';
import 'package:minhasreceitas/services/localstorage_service.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);

  locator.registerLazySingleton(() => FirebaseService('recipes'));
}