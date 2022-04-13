// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum Gender {
  MALE,
  FEMALE,
}

enum Colorz { BLUE, GREEN, RED, YELLOW }

class UserInfo {
  final String name;
  final Gender gender;
  final List<String> colorz;
  final bool student;

  UserInfo(this.name, this.gender, this.colorz, this.student);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': describeEnum(gender),
      'colors': colorz,
      'student': student
    };
  }

  UserInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        gender = Gender.values.firstWhere(
            (element) => describeEnum(element).toString() == json['gender']),
        colorz = List<String>.from(json['colors']),
        student = json['student'];
}
