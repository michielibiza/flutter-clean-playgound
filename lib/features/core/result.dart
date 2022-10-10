abstract class Result<T> {
  Result<S> map<S>(S Function(T t) toS);
}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);

  @override
  Result<S> map<S>(S Function(T t) toS) => Success(toS(data));
}

class HttpError<T> extends Result<T> {
  int statusCode;

  HttpError(this.statusCode);

  @override
  Result<S> map<S>(S Function(T t) toS) => HttpError(statusCode);
}

class Error<T> extends Result<T> {
  Object exception;

  Error(this.exception);

  @override
  Result<S> map<S>(S Function(T t) toS) => Error(exception);
}
