import 'package:dynamic_lock/page/LockPage.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MyApp', initialRoute: '/', routes: {
      '/': (context) => const LockPage(),
      // '/setting': (context) => SettingPage(
      //       keypad: Keypad(),
      //     ),
    });
  }
}
