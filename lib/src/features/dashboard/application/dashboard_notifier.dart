import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_ui_state.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repo_impl.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repository.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class DashboardNotifier extends ChangeNotifier {
  DashboardNotifier() {
    repo = DashboardRepoImpl();
  }
  late final DashboardRepository repo;
  DashboardUiState _state = const DashboardUiState.initial();

  DashboardUiState get state => _state;

  Future<void> getJournals() async {
    _updateState(
      state.copyWith(journalUiState: state.journalUiState.loading()),
    );

    final result = await repo.getJournals();
    _state = state.copyWith(
      journalUiState: result.fold(
        state.journalUiState.exception,
        state.journalUiState.success,
      ),
    );
    _updateState(_state);
  }

  void setTimeRange(TimeRange range) {
    _updateState(state.copyWith(selectedTimeRange: range));
  }

  Future<void> getBioData() async {
    _updateState(
      state.copyWith(
        biometricsUiState: state.biometricsUiState.loading(
          state.biometricsUiState.data,
        ),
      ),
    );

    final result = await repo.getBiometricPoints();
    _state = state.copyWith(
      biometricsUiState: result.fold(
        state.biometricsUiState.exception,
        state.biometricsUiState.success,
      ),
    );
    _updateState(_state);
  }

  void _updateState(DashboardUiState newState) {
    _state = newState;
    notifyListeners();
  }
}

final dashNotifier = DashboardNotifier();
