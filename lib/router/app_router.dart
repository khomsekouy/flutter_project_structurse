import 'package:flutter_project_structure/features/home/presentation/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();
  static final routerConfig = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
