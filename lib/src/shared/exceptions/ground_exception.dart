import 'package:unfold_dash/src/shared/exceptions/app_exception.dart';

final class GroundException extends AppException {
  final String message;

  const GroundException(this.message);

  @override
  String toString() => message;
}
