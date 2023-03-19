import 'package:cackeapp/models/cart_item_model.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String? uid;
  String name;
  String email;
  String phone;
  String role;
  String date;
  List<CartItemModel> cart = [];

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

  addcart(CartItemModel citem) {
    cart.add(citem);
    notifyListeners();
  }

  additemcount(int index) {
    cart[index].qty = cart[index].qty + 1;
    notifyListeners();
  }

  removecartitem(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  clearcart() {
    cart = [];
    notifyListeners();
  }

  removeitemcount(int index) {
    if (cart[index].qty > 0) {
      cart[index].qty = cart[index].qty - 1;
      notifyListeners();
    } else {
      cart.removeAt(index);
      notifyListeners();
    }
  }
}
