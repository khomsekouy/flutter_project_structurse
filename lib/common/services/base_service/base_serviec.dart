import 'package:flutter_project_structure/features/home/domain/model/post_model.dart';
import 'package:flutter_project_structure/provider/storage/user_storage/user_storage.dart';

import '../../../provider/http_client_info/http_client.dart';
import '../end_point.dart';


 class BaseService {
  BaseService({required HttpClient httpClient,
    required UserStorage userStorage})
      : _httpClient = httpClient,
        _userStorage = userStorage;

   final HttpClient _httpClient;
   final UserStorage _userStorage;

   Future<PostModel> getPosts() async {
     try {
       final res = await _httpClient.get(EndPoint.posts);
       return PostModel.fromJson(res);
     } catch (e) {
       rethrow;
     }
   }
}

