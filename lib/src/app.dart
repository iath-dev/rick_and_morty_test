import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/src/bloc/bloc.dart';
import 'package:rick_and_morty_test/src/router/router.dart';
import 'package:rick_and_morty_test/src/services/services.dart';
import 'package:rick_and_morty_test/theme/theme.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CharactersCubit(ApiService())),
        BlocProvider(create: (context) => SearchBloc(ApiService())),
      ],
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        themeMode: ThemeMode.dark,
        title: 'Rick and Morty bt DANNEIR',
        routes: AppRoutes.getAppRoutes(),
        initialRoute: AppRoutes.initialRoute,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
