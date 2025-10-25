import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/journal_dto.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class DashboardUiState {
  final BaseUiState<List<JournalDto>> journalUiState;
  final BaseUiState<List<BiometricsPoint>> biometricsUiState;
  final TimeRange selectedTimeRange;
  final List<BiometricsPoint> filteredDataPoints;
  final bool getLargeDataSet;
  final BiometricsPoint point;

  DashboardUiState({
    required this.journalUiState,
    required this.biometricsUiState,
    required this.selectedTimeRange,
    required this.filteredDataPoints,
    required this.getLargeDataSet,
    required this.point,
  });

  DashboardUiState copyWith({
    BaseUiState<List<JournalDto>>? journalUiState,
    BaseUiState<List<BiometricsPoint>>? biometricsUiState,
    TimeRange? selectedTimeRange,
    List<BiometricsPoint>? filteredDataPoints,
    bool? getLargeDataSet,
    BiometricsPoint? point,
  }) => DashboardUiState(
    journalUiState: journalUiState ?? this.journalUiState,
    biometricsUiState: biometricsUiState ?? this.biometricsUiState,
    getLargeDataSet: getLargeDataSet ?? this.getLargeDataSet,
    filteredDataPoints: filteredDataPoints ?? this.filteredDataPoints,
    selectedTimeRange: selectedTimeRange ?? this.selectedTimeRange,
    point: point ?? this.point,
  );

  DashboardUiState.initial()
    : journalUiState = const IdleState(),
      biometricsUiState = const IdleState(),
      filteredDataPoints = const [],
      getLargeDataSet = false,
      point = BiometricsPoint.empty(),
      selectedTimeRange = TimeRange.d7;
}
