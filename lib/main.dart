import 'package:dynamic_lock/Component/SettingPage.dart';
import 'package:dynamic_lock/Password.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MyApp', initialRoute: '/', routes: {
      '/': (context) => const LockPage(),
      '/setting': (context) => SettingPage(
            keypad: Keypad([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]),
          ),
    });
  }
}

class LockPage extends StatefulWidget {
  const LockPage({super.key});

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  final String _password = '1234';
  String _input = '';
  final Keypad _keypad = Keypad([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);

  void _setInput(String input) {
    setState(() {
      _input += input;
    });
  }

  void _resetInput() {
    setState(() {
      _input = '';
    });
  }

  void _removeInput() {
    setState(() {
      _input = _input.isEmpty ? '' : _input.substring(0, _input.length - 1);
    });
  }

  void _checkPassword() {
    if (_input == _password) {
      print('Correct Password');
    } else {
      print('Incorrect Password');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Enter Password';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: [
          IconButton(
            onPressed: () => {
              () async {
                final settedKeypad = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingPage(keypad: _keypad)));
                _keypad.setKeypad(settedKeypad as List<int>);
              }
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(children: [
        Text(_input),
        Expanded(
          child: GridView.extent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
            children: List.generate(10, (index) {
              return TextButton(
                onPressed: () {
                  print('Button $index');
                  _setInput('$index');
                  print('input: $_input');
                },
                child:
                    Text(key: Key('$index'), '${_keypad.getKeypad()[index]}'),
              );
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () => _checkPassword(),
                icon: const Icon(Icons.check)),
            IconButton(
              onPressed: () => _resetInput(),
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () => _removeInput(),
              icon: const Icon(Icons.backspace),
            )
          ],
        )
      ]),
    );
  }
}
