import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:new_dinker/app/app.dart';
import 'package:new_dinker/home/home.dart';
import 'package:new_dinker/login/login.dart';

import 'package:new_dinker/fetch/view/brand.dart';

GoRouter appRouter(BuildContext context, AppStatus loginState) {
  return GoRouter(
    initialLocation: loginState == AppStatus.authenticated ? '/home': '/login',
    routes: [
      GoRoute(path: '/home', builder: (context, state) => HomePage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/brands', builder: (context, state) => BrandPage()),
    ],
  );
}
