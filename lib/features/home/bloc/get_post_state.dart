part of 'get_post_cubit.dart';

abstract class GetPostState extends Equatable {
  const GetPostState();
}

class GetPostInitial extends GetPostState {
  @override
  List<Object> get props => [];
}

class GetPostLoading extends GetPostState {
  @override
  List<Object> get props => [];
}

class GetPostLoaded extends GetPostState {

  const GetPostLoaded(this.post);
  final List<PostModel> post;

  @override
  List<Object> get props => [post];
}

class GetPostError extends GetPostState {

  const GetPostError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
