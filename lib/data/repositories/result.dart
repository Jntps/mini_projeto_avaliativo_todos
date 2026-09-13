// lib/data/repositories/result.dart
sealed class Result<S, E extends Exception> {}

class Success<S, E extends Exception> extends Result<S, E> {
  final S value;
  Success(this.value);
}

class Failure<S, E extends Exception> extends Result<S, E> {
  final E exception;
  Failure(this.exception);
}