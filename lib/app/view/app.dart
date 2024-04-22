
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/common/shared/environment/environment.dart';
import 'package:flutter_project_structure/provider/app_provider.dart';
import 'package:flutter_project_structure/provider/storage/token_storage/token_storage_provider.dart';
import 'package:flutter_project_structure/provider/storage/user_storage/user_storage.dart';

import '../../common/services/base_service/base_serviec.dart';
import '../../provider/http_client_info/http_client.dart';
import '../../provider/storage/app_stroage/app_storage.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required HttpClient httpClient,
    required EnvironmentType environmentType,
    required UserStorage userStorage,
    required AppStorage appStorage,
    required TokenStorageProvider tokenStorageProvider,
  }) : _httpClient = httpClient,
        _environmentType = environmentType,
        _appStorage = appStorage,
        _userStorage = userStorage,
        _tokenStorageProvider = tokenStorageProvider,
        super();

  final HttpClient _httpClient;
  final EnvironmentType _environmentType;
  final AppStorage _appStorage;
  final TokenStorageProvider _tokenStorageProvider;
  final UserStorage _userStorage;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _httpClient,
        ),
        RepositoryProvider.value(
          value: _appStorage,
        ),
        RepositoryProvider.value(
          value: _tokenStorageProvider,
        ),
        RepositoryProvider.value(
          value: _userStorage,
        ),
        RepositoryProvider<BaseService>(
          create: (context) => BaseService(
            userStorage: _userStorage,
            httpClient: _httpClient,
          ),
        ),
      ],
      child: AppProvider(
        environmentType: _environmentType,
      ),
    );
  }
}
