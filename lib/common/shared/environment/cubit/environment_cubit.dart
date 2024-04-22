import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/common/shared/environment/environment.dart';

part 'environment_state.dart';

class EnvironmentCubit extends Cubit<EnvironmentInitial> {
  EnvironmentCubit() : super(EnvironmentInitial.initial());

  //loadEnvironment method
  Future<void> loadEnvironment(EnvironmentType type) async {
    emit(state.copyWith(status: EnvironmentStatus.loading));
    try{
      final environment = _loadEnvironment(type);
      emit(state.copyWith(
        status: EnvironmentStatus.loaded,
        environment: environment,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: EnvironmentStatus.error,
          message: e.toString(),
      ));
    }
  }
  Environment _loadEnvironment(EnvironmentType type) {
    return Environment.values[type] ?? Environment.isEmpty;
  }
}
