import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_ui_state.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repository.dart';
import 'package:unfold_dash/src/shared/view_model/base_ui_state.dart';

class DashboardNotifier extends Notifier<DashboardUiState> {
  late final DashboardRepository repo;

  @override
  DashboardUiState build() {
    repo = ref.read(dasboardRepoProvider);
    return DashboardUiState.initial();
  }

  Future<void> getJournals() async {
    state = state.copyWith(journalUiState: state.journalUiState.loading());

    final result = await repo.getJournals();
    state = state.copyWith(
      journalUiState: result.fold(
        state.journalUiState.exception,
        state.journalUiState.success,
      ),
    );
  }

  Future<void> getBioData() async {
    state = state.copyWith(
      biometricsUiState: state.biometricsUiState.loading(
        state.biometricsUiState.data,
      ),
    );

    final result = await repo.getBiometricPoints();
    state = state.copyWith(
      biometricsUiState: result.fold(
        state.biometricsUiState.exception,
        state.biometricsUiState.success,
      ),
    );
  }
}

final dashboardNotifierProvider =
    NotifierProvider<DashboardNotifier, DashboardUiState>(
      () => DashboardNotifier(),
    );
