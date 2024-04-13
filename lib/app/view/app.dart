import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_dinker/app/app.dart';
import 'package:new_dinker/theme.dart';

import 'package:new_dinker/navigate/bloc/navigate_bloc.dart';
import 'package:new_dinker/home/view/home_page.dart';

import 'package:new_dinker/fetch/bloc/fetch_bloc.dart';
import 'package:new_dinker/fetch/models/api_client.dart';
import 'package:new_dinker/fetch/view/brand.dart';

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

    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavigationBloc()),
          BlocProvider(create: (context) => FetchBloc(ApiClient("http://127.0.0.1:8000/fetch/starbucks/product_name/카푸치노"))),
          // Add more bloc providers if needed
        ],
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationBrandsState) {
              return BrandPage();
            } else {
              return HomePage();
            }
          },
        ),
      ),
    );
  }
}
