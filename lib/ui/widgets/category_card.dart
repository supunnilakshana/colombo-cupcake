// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Color mainColor = kPrimaryColordark;

  final String titel;
  final String no;
  final Function() b1fun;

  const CategoryCard({
    Key? key,
    required this.titel,
    required this.b1fun,
    required this.no,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: kPrimaryColorlight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Text(
          "$no .",
          style: TextStyle(color: mainColor, fontSize: size.width * 0.057),
        ),
        title: Text(
          titel,
          style: TextStyle(color: mainColor, fontSize: size.width * 0.057),
        ),
        trailing: IconButton(
            onPressed: () {
              b1fun();
            },
            icon: const Icon(Icons.delete)),
      ),
    );
  }
}
