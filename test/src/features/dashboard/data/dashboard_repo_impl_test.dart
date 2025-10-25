import 'package:flutter_test/flutter_test.dart';
import 'package:unfold_dash/src/features/dashboard/data/dashboard_repo_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final DashboardRepoImpl repo;
  setUpAll(() {
    repo = DashboardRepoImpl();
  });
  test('Get biometric points...', () async {
    final data = await repo.getBiometricPoints();

    expect(data.isRight, true);
    expect(data.right.first.hrv, 58.2);
  });

  test('Get journals...', () async {
    final data = await repo.getJournals();

    expect(data.isRight, true);
    expect(data.right.first.mood, 2);
    expect(data.right.first.note, 'Bad sleep');
  });

  group('Check for large data points', () {
    test('get 10000 datapoints', () async {
      final data = await repo.generateLargeBioData(10000);

      expect(data.isRight, true);
      expect(data.right.length, 10000);
    });

    test('get 10000 datapoints and decimate', () async {
      final data = await repo.generateLargeBioData(10000);

      expect(data.isRight, true);
      expect(data.right.length, 10000);

      final decimatedvalues = repo.decimateData(data.right, 500);

      expect(decimatedvalues.isRight, true);
      expect(decimatedvalues.right.length <= 1500, true);
    });

    test('get 4 datapoints and try to decimate', () async {
      final data = await repo.generateLargeBioData(4);

      expect(data.isRight, true);
      expect(data.right.length, 4);

      final decimatedvalues = repo.decimateData(data.right, 5);

      expect(decimatedvalues.isRight, true);
      expect(decimatedvalues.right.length, 4);
    });
  });
}
