import 'package:flutter/material.dart';
import 'package:unfold_dash/app/app.dart';
import 'package:unfold_dash/src/shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.initialise();
  runApp(const MyApp());
}
