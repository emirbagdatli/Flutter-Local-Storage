import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/models/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';

class SecureStorageServices implements LocalStorageService {
  late final FlutterSecureStorage preferences;

  @override
  Future<void> saveData(UserInfo userInfo) async {
    final _name = userInfo.name;

    await preferences.write(key: 'name', value: _name);
    await preferences.write(key: 'student', value: userInfo.student.toString());
    await preferences.write(
        key: 'gender', value: userInfo.gender.index.toString());
    await preferences.write(key: 'colors', value: jsonEncode(userInfo.colorz));
  }

  @override
  Future<UserInfo> readData() async {
    preferences = FlutterSecureStorage();
    var _name = await preferences.read(key: 'name') ?? '';
    var _studentString = await preferences.read(key: 'student') ?? 'false';
    var _student = _studentString.toLowerCase() == 'true' ? true : false;
    var _selectedGenderString = await preferences.read(key: 'gender') ?? '0';
    var _selectedGender = Gender.values[int.parse(_selectedGenderString)];
    var _selectedColorString = await preferences.read(key: 'colors');
    var _selectedColor = _selectedColorString == null
        ? <String>[]
        : List<String>.from(jsonDecode(_selectedColorString));
    return UserInfo(_name, _selectedGender, _selectedColor, _student);
  }
}
