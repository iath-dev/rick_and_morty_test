import 'package:flutter/material.dart';
import 'package:rick_and_morty_test/src/models/models.dart';
import 'package:rick_and_morty_test/src/screens/screens.dart';

class AppRoutes {
  static const String initialRoute = "home";

  static final Map<String, List<RouteItem>> routes = {
    'root': [
      RouteItem(path: "home", screen: const HomeScreen()),
      RouteItem(path: "character", screen: const CharacterScreen()),
    ],
  };

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    final routes$ = routes.values.expand((element) => element).toList();

    for (final option in routes$) {
      appRoutes.addAll({option.path: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
