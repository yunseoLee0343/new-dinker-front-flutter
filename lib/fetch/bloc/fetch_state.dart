abstract class FetchState {
  get brands => null;
}

class FetchLoading extends FetchState {
  final List<String> brands;

  FetchLoading(this.brands);
}

class FetchError extends FetchState {
  final String error;

  FetchError(this.error);
}