import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';


enum EnvironmentType {
  none,
  development,
  staging,
  production,
}
class Environment extends Equatable {

  const Environment({
    required this.name,
    required this.baseUrl,
    required this.apiVersion,
    this.type = EnvironmentType.development,
    this.envColor = Colors.transparent,
  });

  static const isEmpty = Environment(
    name: '',
    baseUrl: '',
    apiVersion: '',
    type: EnvironmentType.none,
    envColor: Colors.transparent,
  );

  final String name;
  final String baseUrl;
  final String apiVersion;
  final EnvironmentType type;
  final Color envColor;

  static Map<EnvironmentType, Environment> get values => {
    EnvironmentType.development: const Environment(
      name: 'Dev',
      baseUrl: 'https://demo/api',
      apiVersion: 'v1',
      type: EnvironmentType.development,
      envColor: AppColors.kColorRed,
    ),
    EnvironmentType.staging: const Environment(
      name: 'Staging',
      baseUrl: 'https://demo/api',
      apiVersion: 'v1',
      type: EnvironmentType.staging,
      envColor: AppColors.kColorOrange,
    ),
    EnvironmentType.production: const Environment(
      name: 'Production',
      baseUrl: 'https://example.com',
      apiVersion: 'v1',
      type: EnvironmentType.production,
      envColor: AppColors.kColorBlue,
    ),
  };
  @override
  List<Object?> get props => [name, baseUrl, apiVersion, type, envColor];
}
