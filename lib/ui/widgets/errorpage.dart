import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Errorpage extends StatelessWidget {
  final double size;

  const Errorpage({Key? key, required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Lottie.asset("assets/animations/error.json", width: size)),
    );
  }
}
