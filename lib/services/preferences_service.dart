import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();

  factory PreferencesService() {
    return _instance;
  }

  PreferencesService._internal();
  late final SharedPreferences _preferences;

  initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  set setInit(bool value) {
    _preferences.setBool('Init', value);
  }

  bool get getInit {
    return _preferences.getBool('Init') ?? false;
  }

  set setNameUser(String value) {
    _preferences.setString('nameUser', value);
  }

  String get getNameUser {
    return _preferences.getString('nameUser') ?? 'not-valid';
  }

  bool get getActiveBiometric {
    return _preferences.getBool('enabledBiometric') ?? false;
  }

  set setActiveBiometric(bool value) {
    _preferences.setBool('enabledBiometric', value);
  }

  bool get getIsAuthticate {
    return _preferences.getBool('isAuth') ?? false;
  }

  set setIsAuthticate(bool value) {
    _preferences.setBool('isAuth', value);
  }

  logOut() {
    _preferences.remove('isAuth');
  }
}
