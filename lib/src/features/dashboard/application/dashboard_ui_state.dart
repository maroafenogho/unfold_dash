import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/journal_dto.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class DashboardUiState {
  final BaseUiState<List<JournalDto>> journalUiState;
  final BaseUiState<List<BiometricsPoint>> biometricsUiState;
  final TimeRange selectedTimeRange;
  final List<BiometricsPoint> filteredDataPoints;
  final bool getLargeDataSet;

  DashboardUiState({
    required this.journalUiState,
    required this.biometricsUiState,
    required this.selectedTimeRange,
    required this.filteredDataPoints,
    required this.getLargeDataSet,
  });

  DashboardUiState copyWith({
    BaseUiState<List<JournalDto>>? journalUiState,
    BaseUiState<List<BiometricsPoint>>? biometricsUiState,
    TimeRange? selectedTimeRange,
    List<BiometricsPoint>? filteredDataPoints,
    bool? getLargeDataSet,
  }) => DashboardUiState(
    journalUiState: journalUiState ?? this.journalUiState,
    biometricsUiState: biometricsUiState ?? this.biometricsUiState,
    getLargeDataSet: getLargeDataSet ?? this.getLargeDataSet,
    filteredDataPoints: filteredDataPoints ?? this.filteredDataPoints,
    selectedTimeRange: selectedTimeRange ?? this.selectedTimeRange,
  );

  DashboardUiState.initial()
    : journalUiState = const IdleState(),
      biometricsUiState = const IdleState(),
      filteredDataPoints = const [],
      getLargeDataSet = false,
      selectedTimeRange = TimeRange.d7;
}
