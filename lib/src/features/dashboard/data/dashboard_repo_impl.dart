import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repository.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/biometrics_point.dart';
import 'package:unfold_dash/src/features/dashboard/domain/dtos/response/journal_dto.dart';
import 'package:unfold_dash/src/shared/exceptions/exceptions.dart';
import 'package:unfold_dash/src/shared/typedefs.dart';
import 'package:unfold_dash/src/shared/utility/utility.dart';

class DashboardRepoImpl implements DashboardRepository {
  @override
  Future<EitherExceptionOr<List<BiometricsPoint>>> getBiometricPoints() async {
    final bioJson = await _loadBundleString('biometrics_90d');
    return await processData(
      (json) => switch (json['list']) {
        final List list? =>
          list.map((e) => BiometricsPoint.fromJson(e as Json)).toList(),
        _ => const [],
      },
      bioJson,
    );
  }

  @override
  Future<EitherExceptionOr<List<JournalDto>>> getJournals() async {
    final journalsJson = await _loadBundleString('journals');
    return await processData(
      (json) => switch (json['list']) {
        final List list? =>
          list.map((e) => JournalDto.fromJson(e as Json)).toList(),
        _ => const [],
      },
      journalsJson,
    );
  }
}

Future<EitherExceptionOr<dynamic>> _loadBundleString(String assetName) async {
  await Future.delayed(Duration(milliseconds: 700 + Random().nextInt(500)));

  if (Random().nextDouble() < 0.10) {
    return Left(GroundException("Network simulation failure. Try again."));
  }
  try {
    final data = jsonDecode(
      await rootBundle.loadString('assets/$assetName.json'),
    );
    return Right(data);
  } catch (e) {
    return Left(GroundException(e.toString()));
  }
}
