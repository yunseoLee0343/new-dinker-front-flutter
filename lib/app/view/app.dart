import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_dinker/app/app.dart';
import 'package:new_dinker/theme.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}


class AppView extends StatelessWidget {
  const AppView({Key? key});

  @override
  Widget build(BuildContext context) {
    final appState = context.select((AppBloc bloc) => bloc.state);

    return MaterialApp.router(
      theme: theme,
      routerConfig: appRouter(context, appState.status),
      //routerDelegate: appRouter(context, appState.status).routerDelegate,
      //routeInformationParser: appRouter(context, appState.status).routeInformationParser,
    );
  }
}