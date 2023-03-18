import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String? uid;
  String name;
  String email;
  String phone;
  String role;
  String date;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'date': date,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> res) {
    return UserModel(
      uid: res['uid'],
      name: res['name'],
      email: res['email'],
      phone: res['phone'] ?? "",
      role: res['role'],
      date: res['date'],
    );
  }

  updateData(UserModel userModel) {
    uid = userModel.uid;
    name = userModel.name;
    email = userModel.email;
    phone = userModel.phone;
    role = userModel.role;
    date = userModel.date;
    notifyListeners();
  }
}
