
import 'package:flutter_project_structure/common/shared/core/base_response_model.dart';

class PostModel {
  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    userId = json.getInt('userId');
    id = json.getInt('id');
    title = json.getString('title');
    body = json.getString('body');
  }
  late int userId;
  late int id;
  late String title;
  late String body;
}


