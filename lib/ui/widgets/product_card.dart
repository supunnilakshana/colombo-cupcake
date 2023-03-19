import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Color mainColor = kPrimaryColordark;

  final String titel;
  final String imgurl;
  final double price;

  final Function() b1fun;

  const ProductCard({
    Key? key,
    required this.titel,
    required this.b1fun,
    required this.imgurl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: kPrimaryColorlight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: SizedBox(
          width: size.width * 0.15,
          child: Image.network(
            imgurl,
          ),
        ),
        title: Text(
          titel,
          style: TextStyle(color: mainColor, fontSize: size.width * 0.057),
        ),
        subtitle: Text("Rs ${price.toStringAsFixed(2)}"),
        trailing: IconButton(
            onPressed: () {
              b1fun();
            },
            icon: const Icon(Icons.delete)),
      ),
    );
  }
}
