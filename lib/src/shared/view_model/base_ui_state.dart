import 'package:flutter/material.dart';
import 'package:unfold_dash/src/shared/shared.dart';

typedef VoidWidgetCallback = Widget Function();
Widget _kIdleClosure() => const SizedBox.shrink();

sealed class BaseUiState<T> {
  const BaseUiState();
  T? get data => null;
  AppException? get error => null;
  bool get hasData => data != null;

  bool get isError => false;
  bool get isSuccess => false;
  bool get isLoading => false;

  Widget when({
    required VoidWidgetCallback onLoading,
    required Widget Function(T state) onSuccess,
    required Widget Function(AppException error) onError,
    VoidWidgetCallback onIdle = _kIdleClosure,
  }) => switch (this) {
    IdleState() => onIdle(),
    SuccessState<T>(result: final data) => onSuccess(data),
    LoadingState<T>() => onLoading(),
    ErrorState<T>(:final exception) => onError(exception),
  };
}

class IdleState<T> extends BaseUiState<T> {
  const IdleState();
}

class LoadingState<T> extends BaseUiState<T> {
  LoadingState([this.data]);

  @override
  final T? data;

  @override
  bool get isLoading => true;
}

class ErrorState<T> extends BaseUiState<T> {
  final AppException exception;

  ErrorState(this.exception, [this.data]);

  @override
  final T? data;

  @override
  AppException? get error => exception;

  @override
  bool get isError => true;
}

class SuccessState<T> extends BaseUiState<T> {
  final T result;

  SuccessState(this.result);

  @override
  T? get data => result;

  @override
  bool get isSuccess => true;
}

extension BaseUiStateX<T> on BaseUiState<T> {
  BaseUiState<T> loading([T? data]) {
    if (data != null) return LoadingState(data);

    return switch (this) {
      LoadingState<T>(:final data?) => LoadingState(data),
      _ => LoadingState(),
    };
  }

  BaseUiState<T> success(T data) {
    return SuccessState(data);
  }

  BaseUiState<T> exception(AppException error) {
    return ErrorState(error);
  }
}
