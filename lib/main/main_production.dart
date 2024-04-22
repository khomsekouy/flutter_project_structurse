import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_structure/app/app.dart';
import 'package:flutter_project_structure/main/bootstrap/bootstrap.dart';
import 'package:flutter_project_structure/provider/storage/storage_impl/storage_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/interceptors/authentication_queued_interceptor.dart';
import '../common/shared/environment/environment.dart';
import '../provider/http_client_info/dio_http_client.dart';
import '../provider/storage/app_stroage/app_storage.dart';
import '../provider/storage/token_storage/token_storage_provider.dart';
import '../provider/storage/user_storage/user_storage.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
 bootstrap((sharedPreference) async {
   final storage = StorageImpl(
     sharedPreferences: sharedPreference,
   );
   final tokenProvider = TokenStorageProvider(storage: storage);
   final userStorage = UserStorage(storageImpl: storage);
   final appStorage = AppStorage(storageImpl: storage);
   const environmentType = EnvironmentType.production;
   final environment = Environment.values[environmentType];
   if (environment != null) {
     log('Environment: ${environment.name}');
     log('BaseUrl: ${environment.baseUrl}');
     log('API version: ${environment.apiVersion}');
   }
   final httpClient = DioHttpClient(
     dio: Dio(),
      baseUrl: '${environment?.baseUrl}/${environment?.apiVersion}',
     tokenStorageProvider: tokenProvider,
      interceptors: [
        AuthenticationQueuedInterceptor(
          tokenStorage: tokenProvider,
          baseUrl: '${environment?.baseUrl}/${environment?.apiVersion}',
        ),
      ],
   );
   return ProviderScope(
     child: App(
       httpClient: httpClient,
       environmentType: environmentType,
       tokenStorageProvider: tokenProvider,
       userStorage: userStorage,
       appStorage: appStorage,
     ),
   );
 });
}
