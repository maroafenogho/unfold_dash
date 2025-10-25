import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_ui_state.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repo_impl.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repository.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/shared/shared.dart';

class DashboardNotifier extends ChangeNotifier {
  DashboardNotifier(this.repo) {
    Future.microtask(() {
      getBioData();
      // getJournals();
    });
  }
  DashboardRepository repo;
  DashboardUiState _state = DashboardUiState.initial();

  DashboardUiState get state => _state;

  Future<void> getJournals() async {
    _updateState(
      _state.copyWith(journalUiState: _state.journalUiState.loading()),
    );

    final result = await repo.getJournals();

    _updateState(
      _state.copyWith(
        journalUiState: result.fold(
          _state.journalUiState.exception,
          _state.journalUiState.success,
        ),
      ),
    );
  }

  void setTouchedPoint(BiometricsPoint point) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _state = _state.copyWith(point: point);
      _updateState(_state);
    });
  }

  void updateGetLargeData(bool getLargeDataSet) {
    if (getLargeDataSet) {
      getLargeData(10200);
    } else {
      getBioData();
    }
    _updateState(_state.copyWith(getLargeDataSet: getLargeDataSet));
  }

  Future<void> getBioData() async {
    _updateState(
      _state.copyWith(
        biometricsUiState: _state.biometricsUiState.loading(
          _state.biometricsUiState.data,
        ),
      ),
    );

    final result = await repo.getBiometricPoints();
    _state = _state.copyWith(
      biometricsUiState: result.fold(_state.biometricsUiState.exception, (r) {
        return _state.biometricsUiState.success(r);
      }),
    );
    filterBioData(
      _state.selectedTimeRange,
      _state.biometricsUiState.data ?? [],
    );
  }

  void filterBioData(
    TimeRange range,
    List<BiometricsPoint> data, {
    int targetSize = 100,
  }) {
    if (data.isNotEmpty) {
      DateTime lastDate = data.last.date.getOrElse(DateTime.now());
      DateTime startDate = lastDate.subtract(Duration(days: range.days));
      if (data.length > 500 && range != TimeRange.d7) {
        final decimatedValues = repo.decimateData(
          data,
          range == TimeRange.d30 ? 500 : 400,
        );

        final datapoints = decimatedValues.fold(
          (left) => const <BiometricsPoint>[],
          (right) => right,
        );

        DateTime lastDate = datapoints.last.date.getOrElse(DateTime.now());
        DateTime startDate = lastDate.subtract(Duration(days: range.days));
        _state = _state.copyWith(
          selectedTimeRange: range,
          filteredDataPoints: datapoints
              .where(
                (element) =>
                    element.date
                        .getOrElse(DateTime.now())
                        .isAfter(startDate.subtract(const Duration(days: 1))) &&
                    element.date
                        .getOrElse(DateTime.now())
                        .isBefore(lastDate.add(const Duration(days: 1))),
              )
              .toList(),
        );
      } else {
        _state = _state.copyWith(
          selectedTimeRange: range,
          filteredDataPoints: data
              .where(
                (element) =>
                    element.date
                        .getOrElse(DateTime.now())
                        .isAfter(startDate.subtract(const Duration(days: 1))) &&
                    element.date
                        .getOrElse(DateTime.now())
                        .isBefore(lastDate.add(const Duration(days: 1))),
              )
              .toList(),
        );
      }
    }
    _updateState(_state);
  }

  void decimateData(List<BiometricsPoint> data, int targetSize) {
    final dec = repo.decimateData(data, targetSize);

    final deal = dec.fold(
      (left) => const <BiometricsPoint>[],
      (right) => right,
    );
    _updateState(
      _state.copyWith(
        biometricsUiState: _state.biometricsUiState.success(deal),
      ),
    );
  }

  Future<void> getLargeData(int points) async {
    _updateState(
      _state.copyWith(
        biometricsUiState: _state.biometricsUiState.loading(
          _state.biometricsUiState.data,
        ),
      ),
    );

    final result = await repo.generateLargeBioData(points);
    _state = _state.copyWith(
      biometricsUiState: result.fold(_state.biometricsUiState.exception, (r) {
        return _state.biometricsUiState.success(r);
      }),
    );
    filterBioData(
      _state.selectedTimeRange,
      _state.biometricsUiState.data ?? [],
    );
  }

  void _updateState(DashboardUiState newState) {
    _state = newState;
    notifyListeners();
  }
}

final dashNotifier = DashboardNotifier(DashboardRepoImpl());
