import 'package:dynamic_lock/model/keypad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingPage extends StatefulWidget {
  final Keypad keypad;
  const SettingPage({super.key, required this.keypad});

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late Keypad _keypad;
  late List<int> _initialKeypad;
  @override
  void initState() {
    super.initState();
    _keypad = widget.keypad; // keypad 값을 가져와서 _keypadValues에 저장
    _initialKeypad = _keypad.getKeypad();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
      ),
      body: Column(children: [
        Expanded(
          child: GridView.extent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
            children: List.generate(_initialKeypad.length, (index) {
              return SizedBox(
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue: _initialKeypad[index].toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (input) => setState(() {
                    // 입력 값 처리
                    if (input == '') {
                      input = '0';
                      _initialKeypad[index] = 0;
                    } else {
                      int value = int.parse(input);
                      if (value >= 0 || value <= 9) {
                        _initialKeypad[index] = value;
                      }
                    }
                    print(_initialKeypad);
                  }),
                ),
              );
            }),
          ),
        ),
        IconButton(
            key: const Key('keypadSaveBtn'),
            onPressed: () => () {
                  _keypad.setKeypad(_initialKeypad);
                  Navigator.pop(context, _initialKeypad);
                  print('clicked');
                },
            icon: const Icon(Icons.check))
      ]),
    ));
  }
}
