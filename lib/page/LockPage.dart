import 'package:dynamic_lock/model/password.dart';
import 'package:dynamic_lock/model/keypad.dart';
import 'package:dynamic_lock/page/SettingPage.dart';
import 'package:flutter/material.dart';

class LockPage extends StatefulWidget {
  const LockPage({super.key});

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  late Password _password;
  late Keypad _keypad;
  String _input = '';
  List<int> keypad = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  @override
  void initState() {
    super.initState();
    _password = Password();
    _keypad = Keypad();

    // 개선 사항 : init 함수를 constructor에서 호출하도록 수정
    _keypad.init().then((_) {
      _password.init();
      setState(() {
        keypad = _keypad.getKeypad();
      });
    });
  }

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
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingPage(keypad: _keypad)));
                _keypad.loadKeypad();
              }
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(children: [
        Text(_input),
        Expanded(
          key: const Key('keypad_space'),
          child: GridView.extent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
            children: List.generate(10, (index) {
              return TextButton(
                onPressed: () {
                  _setInput('${keypad[index]}');
                },
                child: Text(key: Key('$index'), '${keypad[index]}'),
              );
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                key: const Key('checkPWBtn'),
                onPressed: () => _password.checkPassword(_input),
                icon: const Icon(Icons.check)),
            IconButton(
              key: const Key('resetInputBtn'),
              onPressed: () => _resetInput(),
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              key: const Key('removeInputBtn'),
              onPressed: () => _removeInput(),
              icon: const Icon(Icons.backspace),
            ),
          ],
        )
      ]),
    );
  }
}
