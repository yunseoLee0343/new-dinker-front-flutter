import 'package:flutter/widgets.dart';
import 'package:new_dinker/app/app.dart';
import 'package:new_dinker/home/home.dart';
import 'package:new_dinker/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
    AppStatus state,
    List<Page<dynamic>> pages,
    ) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}