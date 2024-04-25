import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  late SharedPreferences _prefs;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData<T>(String key, T value) async {
    switch (T) {
      case String:
        {
          await _prefs.setString(key, value as String);
          break;
        }
      case const (List<int>):
        {
          String encodedList =
              (value as List<int>).join(','); // List<int>를 문자열로 직렬화
          await _prefs.setString(key, encodedList);
          break;
        }
    }
  }

  // 값을 불러오는 함수
  T? loadData<T>(String key) {
    String? value = _prefs.getString(key);
    if (value == null) {
      return null;
    }
    switch (T) {
      case String:
        {
          return value as T ?? '' as T;
        }
      case const (List<int>):
        {
          if (value.isNotEmpty) {
            return value.split(',').map((n) => int.parse(n)).toList() as T;
          } else {
            return null as T;
          }
        }
      default:
        {
          print(value);
          throw Exception('Unsupported data type');
        }
    }
  }
}
