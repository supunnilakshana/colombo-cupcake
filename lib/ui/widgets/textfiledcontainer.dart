// ignore: file_names
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:flutter/material.dart';

class Textfiledcontainer extends StatelessWidget {
  final Widget child;
  const Textfiledcontainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.65,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03, vertical: size.height * 0.003),
      decoration: BoxDecoration(
          color: kPrimaryColorlight, borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
