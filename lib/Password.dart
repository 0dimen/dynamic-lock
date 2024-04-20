class Password {
  late String _password;
  getPassword() {
    return _password;
  }

  setPassword(String password) {
    _password = password;
  }

  Password(this._password);
}

class Keypad {
  late List<int> _keypad;

  getKeypad() {
    return _keypad;
  }

  setKeypad(List<int> keypad) {
    _keypad = keypad;
  }

  Keypad(this._keypad);
}
