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
}
