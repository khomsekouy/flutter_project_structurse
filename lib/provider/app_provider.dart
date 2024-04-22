import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/common/services/base_service/base_serviec.dart';
import 'package:flutter_project_structure/common/shared/environment/environment.dart';
import 'package:flutter_project_structure/features/home/bloc/get_post_cubit.dart';

import '../common/shared/environment/cubit/environment_cubit.dart';
import '../common/ui/app_root/app_root.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.environmentType});
  final EnvironmentType environmentType;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EnvironmentCubit>(
          create: (context) =>
          EnvironmentCubit()..loadEnvironment(environmentType),
        ),
        BlocProvider<GetPostCubit>(
          create: (context) => GetPostCubit(
            RepositoryProvider.of<BaseService>(context),
          ),
        ),
      ],
      child: AppRoot(),
    );
  }
}
