import 'dart:async';
import 'package:bloc/bloc.dart';

var selectedIndex = 0;

enum NavigationEvent { home, brands }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigationEvent>((event, emit) {
      emit(mapEventToState(event));
    });
  }

  NavigationState mapEventToState(NavigationEvent event) {
    if (event == NavigationEvent.home) {
      return NavigationHomeState();
    } else if (event == NavigationEvent.brands) {
      return NavigationBrandsState();
    }
    return NavigationInitial();
  }
}

abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationHomeState extends NavigationState {}

class NavigationBrandsState extends NavigationState {}
