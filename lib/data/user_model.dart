import 'package:flutter/material.dart';

// 사용자 정보를 담는 모델 클래스
class UserModel {
  final String id;
  final String password;
  final String name;
  final String phone;

  // 생성자
  UserModel({
    required this.id,
    required this.password,
    required this.name,
    required this.phone,
  });

  // toJson 메서드를 사용하여 객체를 JSON 형식으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'name': name,
      'phone': phone,
    };
  }

  // fromJson 팩토리 메서드를 사용하여 JSON을 객체로 변환
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
    );
  }
  }

  /*  // copyWith 메서드를 사용하여 객체의 일부 속성을 변경한 새로운 객체 반환
  serModel copyWith({
    String? id,
    String? password,
    String? name,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
*/
