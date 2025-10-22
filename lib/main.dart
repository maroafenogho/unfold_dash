import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unfold_dash/src/features/dashboard/application/dashboard_notifier.dart';
import 'package:unfold_dash/src/shared/view_model/base_ui_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                switch (ref
                    .watch(dashboardNotifierProvider)
                    .biometricsUiState) {
                  LoadingState(data: final data) => Column(
                    children: [
                      if (data != null) Text('${data.first.sleepScore}'),
                      CircularProgressIndicator(),
                    ],
                  ),
                  SuccessState(result: final data) => Text(
                    '${data.first.sleepScore}',
                  ),
                  _ => Text('Could not fetch data.\n Please try again'),
                },
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, _) => FloatingActionButton(
          onPressed: () {
            _incrementCounter();
            ref.read(dashboardNotifierProvider.notifier).getBioData();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
