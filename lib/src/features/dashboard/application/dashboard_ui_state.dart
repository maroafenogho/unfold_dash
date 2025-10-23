import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/journal_dto.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class DashboardUiState {
  final BaseUiState<List<JournalDto>> journalUiState;
  final BaseUiState<List<BiometricsPoint>> biometricsUiState;
  final TimeRange selectedTimeRange;

  DashboardUiState({
    required this.journalUiState,
    required this.biometricsUiState,
    required this.selectedTimeRange,
  });

  DashboardUiState copyWith({
    BaseUiState<List<JournalDto>>? journalUiState,
    BaseUiState<List<BiometricsPoint>>? biometricsUiState,
    TimeRange? selectedTimeRange,
  }) => DashboardUiState(
    journalUiState: journalUiState ?? this.journalUiState,
    biometricsUiState: biometricsUiState ?? this.biometricsUiState,
    selectedTimeRange: selectedTimeRange ?? this.selectedTimeRange,
  );

  const DashboardUiState.initial()
    : journalUiState = const IdleState(),
      biometricsUiState = const IdleState(),
      selectedTimeRange = TimeRange.d7;
}
