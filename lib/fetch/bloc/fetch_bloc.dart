import 'package:bloc/bloc.dart';
import '../models/api_client.dart';
import 'fetch_event.dart';
import 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  final ApiClient apiClient;

  FetchBloc(this.apiClient) : super(FetchLoading([])) {
    on<FetchEvent>((event, emit) async {
      if (event == FetchEvent.loading) {
        try {
          final brands = await apiClient.fetch('/hot');
          emit(FetchLoading(brands));
        } catch (error) {
          emit(FetchError(error.toString()));
        }
      }
    });
  }
}



