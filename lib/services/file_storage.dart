import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_storage/models/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageServices implements LocalStorageService {
  _getfilePath() async {
    var filePath = await getApplicationDocumentsDirectory();
    debugPrint(filePath.path);
    return filePath.path;
  }

  FileStorageServices() {
    _createFile();
  }

  Future<File> _createFile() async {
    var file = File(await _getfilePath() + '/info.json');
    return file;
  }

  @override
  Future<void> saveData(UserInfo userInfo) async {
    var file = await _createFile();
    await file.writeAsString(jsonEncode(userInfo));
  }

  @override
  Future<UserInfo> readData() async {
    try {
      var file = await _createFile();
      var stringData = await file.readAsString();
      var json = jsonDecode(stringData);
      return UserInfo.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
    }
    return UserInfo('', Gender.MALE, [], false);
  }
}
