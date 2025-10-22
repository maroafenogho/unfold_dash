import 'package:unfold_dash/src/shared/shared.dart';

typedef Json = Map<String, dynamic>;
typedef EitherExceptionOrEmpty = Either<AppException, Map>;
typedef EitherExceptionOr<T> = Either<AppException, T>;
