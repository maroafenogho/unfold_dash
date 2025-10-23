import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_ui_state.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repo_impl.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repository.dart';
import 'package:unfold_dash/src/shared/view_model/base_ui_state.dart';

class DashboardNotifier extends ChangeNotifier {
  DashboardNotifier(){
    repo = DashboardRepoImpl();
  }
  late final DashboardRepository repo;
  DashboardUiState state = DashboardUiState.initial();


  Future<void> getJournals() async {
    state = state.copyWith(journalUiState: state.journalUiState.loading());

    final result = await repo.getJournals();
    state = state.copyWith(
      journalUiState: result.fold(
        state.journalUiState.exception,
        state.journalUiState.success,
      ),
    );
  notifyListeners();

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
  notifyListeners();
  }
}
final dashNotifier = DashboardNotifier();