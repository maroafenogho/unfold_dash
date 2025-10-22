import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/journal_dto.dart';
import 'package:unfold_dash/src/shared/view_model/base_ui_state.dart';

class DashboardUiState {
  final BaseUiState<List<JournalDto>> journalUiState;
  final BaseUiState<List<BiometricsPoint>> biometricsUiState;

  DashboardUiState({
    required this.journalUiState,
    required this.biometricsUiState,
  });

  DashboardUiState copyWith({
    BaseUiState<List<JournalDto>>? journalUiState,
    BaseUiState<List<BiometricsPoint>>? biometricsUiState,
  }) => DashboardUiState(
    journalUiState: journalUiState ?? this.journalUiState,
    biometricsUiState: biometricsUiState ?? this.biometricsUiState,
  );

  const DashboardUiState.initial()
    : journalUiState = const IdleState(),
      biometricsUiState = const IdleState();
}
