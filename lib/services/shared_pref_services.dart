import 'package:flutter/material.dart';
import 'package:flutter_storage/models/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefenceServices implements LocalStorageService {
  late final preferences;
  @override
  Future<void> saveData(UserInfo userInfo) async {
    final _name = userInfo.name;
    preferences.setString('name', _name);
    preferences.setBool('student', userInfo.student);
    preferences.setInt('gender', userInfo.gender.index);
    preferences.setStringList('colors', userInfo.colorz);
  }

  @override
  Future<UserInfo> readData() async {
    final preferences = await SharedPreferences.getInstance();

    var _name = preferences.getString('name') ?? '';
    var _student = preferences.getBool('student') ?? false;
    var _selectedGender = Gender.values[preferences.getInt('gender') ?? 0];
    var _selectedColor = preferences.getStringList('colors') ?? <String>[];
    return UserInfo(_name, _selectedGender, _selectedColor, _student);
  }
}
