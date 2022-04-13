import 'package:flutter_storage/models/my_models.dart';

abstract class LocalStorageService {
  Future<void> saveData(UserInfo userInfo);

  Future<UserInfo> readData();
}
