import 'package:unfold_dash/src/shared/exceptions/app_exception.dart';

final class ObjectParseException extends AppException {
  const ObjectParseException(this.stacktraceInfo);

  final StackTrace? stacktraceInfo;

  @override
  String toString() =>
      'We encountered a problem trying to parse your data. Please contact support if this persists...';
}
