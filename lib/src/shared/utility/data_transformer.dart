import 'package:flutter/foundation.dart';
import 'package:unfold_dash/src/shared/shared.dart';

Future<EitherExceptionOr<E>> processData<E>(
  E Function(dynamic json) transformer,
  EitherExceptionOr<dynamic> response,
) async {
  if (response.isLeft) return Left(response.left);

  return await compute(
    (message) => _transformData(response.right, transformer),
    response.right,
  );
}

EitherExceptionOr<E> _transformData<E>(
  dynamic data,
  E Function(dynamic) transformer,
) {
  try {
    if (data case final Json json?) {
      return Right(transformer(json));
    }
    if (data case final List list?) {
      return Right(transformer({'list': list}));
    }
    return Left(GroundException('Could not process Data'));
  } on TypeError catch (e) {
    return Left(ObjectParseException(e.stackTrace));
  } on Exception catch (e) {
    return Left(GroundException(e.toString()));
  }
}
