part of 'environment_cubit.dart';

enum EnvironmentStatus { initial, loading, loaded, error }

class EnvironmentInitial extends Equatable {
  const EnvironmentInitial({
    this.status = EnvironmentStatus.initial,
    this.environment = Environment.isEmpty,
    this.message,
  });
  factory EnvironmentInitial.initial() => const EnvironmentInitial();
  final EnvironmentStatus status;
  final Environment environment;
  final String? message;

  // copyWith method
  EnvironmentInitial copyWith({
    EnvironmentStatus? status,
    Environment? environment,
    String? message,
  }) {
    return EnvironmentInitial(
      status: status ?? this.status,
      environment: environment ?? this.environment,
      message: message ?? this.message,
    );
  }
  @override
  List<Object> get props => [status, environment];
}
