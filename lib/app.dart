import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/features/auth/data/repositories/auth_repository.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:survey_app/features/auth/presentation/pages/login_page.dart';
import 'package:survey_app/features/survey/data/repositories/survey_repository.dart';
import 'package:survey_app/features/location/data/repositories/location_repository.dart';
import 'package:survey_app/features/location/presentation/bloc/location_bloc.dart';

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => SurveyRepository(),
        ),
        RepositoryProvider(
          create: (context) => LocationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LocationBloc(
              repository: context.read<LocationRepository>(),
            )..add(LoadProvinces()),
          ),
        ],
        child: MaterialApp(
          title: 'Survey App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: const LoginPage(),
        ),
      ),
    );
  }
}