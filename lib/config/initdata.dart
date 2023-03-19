import 'package:cackeapp/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const testbunimg =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh5frP2WUiJbwPVf2Af1wi8sRmAggvSfXCzw&usqp=CAU";

const guserimg =
    "https://www.clipartmax.com/png/middle/319-3191274_male-avatar-admin-profile.png";

const addtumb =
    "https://firebasestorage.googleapis.com/v0/b/cupcakeapp-b43c6.appspot.com/o/initdata%2Fcupcake.png?alt=media&token=5f696380-5a8e-4cdb-aba4-0200bbf5d72c";
const userimagebucket = "images/users";
const postimagebucket = "images/posts/";

const int resok = 1;
const int resfail = 0;
const String sucesscode = "sucessfull";

class CollectionPath {
  static const userpath = "users/";
  static const categorypath = "categories/";
  static const productpath = "products/";
  static const itempath = "items/";
}

class ItemType {
  static const bakery = "b";
  static const coffe = "c";
}

const int maxad = 15;

enum UserRole { admin, member }

String getpossition(String role) {
  int r = int.parse(role);

  if (r == 0) {
    return "Admin";
  } else if (r == 1) {
    return "Member";
  } else {
    return "Unknown";
  }
}

Widget getLoadinganimi(Size size) {
  return Lottie.asset("assets/animations/loadinganimi.json",
      width: size.width * 0.26);
}

final CategoryModel defCategory = CategoryModel(name: "All", id: "-1");
