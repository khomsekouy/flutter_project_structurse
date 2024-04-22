import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_structure/main/bootstrap/bootstrap.dart';

import '../app/view/app.dart';
import '../common/interceptors/authentication_queued_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/shared/environment/environment.dart';
import '../provider/http_client_info/dio_http_client.dart';
import '../provider/storage/app_stroage/app_storage.dart';
import '../provider/storage/storage_impl/storage_impl.dart';
import '../provider/storage/token_storage/token_storage_provider.dart';
import '../provider/storage/user_storage/user_storage.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap((sharedPreferences) async {
    final storage = StorageImpl(
      sharedPreferences: sharedPreferences,
    );
    final tokenStorageProvider =
    TokenStorageProvider(storage: storage);
    final userStorage = UserStorage(storageImpl: storage);
    final appStorage = AppStorage(storageImpl: storage);

    const environmentType = EnvironmentType.development;
    final environment = Environment.values[environmentType];
    if (environment != null) {
      print('Environment: ${environment.name}');
      print('BaseUrl: ${environment.baseUrl}');
      print('API version: ${environment.apiVersion}');
    }

    final httpClient = DioHttpClient(
      dio: Dio(),
      baseUrl: '${environment?.baseUrl}/${environment?.apiVersion}',
      tokenStorageProvider: tokenStorageProvider,
      interceptors: [
        AuthenticationQueuedInterceptor(
          tokenStorage: tokenStorageProvider,
          baseUrl: '${environment?.baseUrl}/${environment?.apiVersion}',
        ),
      ],
    );
    return ProviderScope(
      child: App(
        // in hear we can pass all the providers
        httpClient: httpClient,
        environmentType: environmentType,
        userStorage: userStorage,
        appStorage: appStorage,
        tokenStorageProvider: tokenStorageProvider,
      ),
    );
  });
}
