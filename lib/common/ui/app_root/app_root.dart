import 'package:flutter/material.dart';
import 'package:flutter_project_structure/router/app_router.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/loader_overlay_mode_banner_widget.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.routerConfig,
      builder: (context, child) {
        return LoaderOverlayModeBannerWidget(child: child ?? Container());
      },
    );
  }
}
