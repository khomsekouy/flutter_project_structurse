import 'dart:async';

import '../storage_impl/storage_impl.dart';

class UserStorage {
  UserStorage({
   required StorageImpl storageImpl
  }) : _storageImpl = storageImpl;
  final StorageImpl _storageImpl;

  static const _userInfo = '__user_info_key__';
  // create user stream controller
  final _userStream = StreamController<String?>.broadcast();
}
