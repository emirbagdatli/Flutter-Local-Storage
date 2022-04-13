import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/models/my_models.dart';
import 'package:flutter_storage/services/file_storage.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:flutter_storage/services/seruce_storage.dart';
import 'package:flutter_storage/services/shared_pref_services.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({Key? key}) : super(key: key);

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  var _selectedGender = Gender.MALE;
  var _selectedColor = <String>[];
  var _student = false;
  final TextEditingController _nameController = TextEditingController();
  final LocalStorageService _preferenceService = SecureStorageServices();
  /*final LocalStorageService _preferenceService2 = SharedPrefenceServices();
  final LocalStorageService _preferenceService3 = FileStorageServices(); */

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preference'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
          ),
          for (var item in Gender.values)
            _buildRadioListTiles(describeEnum(item), item),
          for (var item in Colorz.values) _buildCheckBoxListTiles(item),
          SwitchListTile(
              title: const Text('Are you a student?'),
              value: _student,
              onChanged: (bool student) {
                _student = student;
                setState(() {});
              }),
          TextButton(
              onPressed: () {
                var _userInfo = UserInfo(_nameController.text, _selectedGender,
                    _selectedColor, _student);
                _preferenceService.saveData(_userInfo);
              },
              child: const Text('Save')),
        ],
      ),
    );
  }

  Widget _buildCheckBoxListTiles(Colorz color) {
    return CheckboxListTile(
        title: Text(describeEnum(color)),
        value: _selectedColor.contains(describeEnum(color)),
        onChanged: (bool? value) {
          if (value == false) {
            _selectedColor.remove(describeEnum(color));
          } else {
            _selectedColor.add(describeEnum(color));
          }
          setState(() {});
        });
  }

  Widget _buildRadioListTiles(String title, Gender gender) {
    return RadioListTile(
        title: Text(title),
        value: gender,
        groupValue: _selectedGender,
        onChanged: (Gender? selectGender) {
          setState(() {
            _selectedGender = selectGender!;
          });
        });
  }

  void _readData() async {
    var info = await _preferenceService.readData();
    _nameController.text = info.name;
    _selectedGender = info.gender;
    _selectedColor = info.colorz;
    _student = info.student;
    setState(() {});
  }
}
