import 'package:dynamic_lock/services/shared_preferences_manager.dart';

class Keypad {
  late List<int> _keypad;
  late SharedPreferencesManager _prefs;

  // 저장된 키패드 정보 가져오는 함수.
  getKeypad() {
    return _keypad;
  }

  // sharedPreferences에 keypad값 저장하는 함수.
  setKeypad(List<int> keypad) {
    _prefs.saveData('keypad', keypad).then((value) => _keypad = keypad);
  }

  // shared preferences에 저장된 keypad 값 가져오는 함수.
  loadKeypad() {
    // 로컬 값을 가져옴.
    List<int>? value = _prefs.loadData<List<int>>('keypad');
    if (value != null) {
      // 로컬에 저장되어 있는 경우, 로컬값으로 설정해줌.
      _keypad = value;
    } else {
      // 기본값 설정
      setKeypad([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]);
    }
  }

  // 초기화 함수.
  Future<void> init() async {
    _prefs = SharedPreferencesManager();
    await _prefs.init();
    await loadKeypad();
  }
}
