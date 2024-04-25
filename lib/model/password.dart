import 'package:dynamic_lock/services/shared_preferences_manager.dart';

class Password {
  late String _password;
  late SharedPreferencesManager _prefs;

  _getPassword() {
    return _password;
  }

  _setPassword(String password) async {
    await _prefs.saveData('password', password);
    _password = password;
  }

  loadPassword() {
    String? value = _prefs.loadData<String>('password');
    if (value != null) {
      _password = value;
    } else {
      _setPassword('0000');
    }
  }

  Future<void> init() async {
    _prefs = SharedPreferencesManager();
    await _prefs.init();
    await loadPassword();
  }

  bool checkPassword(String? input) {
    return (input == _password) ? true : false;
  }
}
