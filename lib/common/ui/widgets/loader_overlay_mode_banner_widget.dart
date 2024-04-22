import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../shared/colors/app_colors.dart';
import '../../shared/environment/cubit/environment_cubit.dart';
import '../../shared/environment/environment.dart';

class LoaderOverlayModeBannerWidget extends StatelessWidget {
  const LoaderOverlayModeBannerWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayHeight: 100,
      overlayWidgetBuilder: (_) {
        return Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              colors: const [AppColors.kPrimaryColor],
              strokeWidth: 2,
            ),
          ),
        );
      },
      overlayWidth: 100,
      overlayColor: Colors.black.withOpacity(.3),
      child: BlocSelector<EnvironmentCubit, EnvironmentInitial,
          EnvironmentInitial>(
        selector: (state) {
          return state;
        },
        builder: (context, state) {
          if (state.environment.type == EnvironmentType.production ||
              state.environment.type == EnvironmentType.none) {
            return child;
          }
          final color = state.environment.envColor;
          return Banner(
            message: state.environment.name,
            location: BannerLocation.topEnd,
            color: color,
            child: child,
          );
        },
      ),
    );
  }
}
