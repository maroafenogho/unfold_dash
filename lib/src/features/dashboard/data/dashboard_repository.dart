import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/journal_dto.dart';
import 'package:unfold_dash/src/shared/shared.dart';

abstract interface class DashboardRepository {
  Future<EitherExceptionOr<List<JournalDto>>> getJournals();
  Future<EitherExceptionOr<List<BiometricsPoint>>> getBiometricPoints();
}
