import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/common/services/base_service/base_serviec.dart';

import '../domain/model/post_model.dart';

part 'get_post_state.dart';

class GetPostCubit extends Cubit<GetPostState> {
  GetPostCubit(this._baseService) : super(GetPostInitial());

  final BaseService _baseService;
  // fetch Post data
  Future<void> fetchPostData() async {
    emit(GetPostLoading());
    try {
      final post = await _baseService.getPosts();
      emit(GetPostLoaded(post as List<PostModel>));
    } catch (e) {
      emit(GetPostError(e.toString()));
    }
  }
}

