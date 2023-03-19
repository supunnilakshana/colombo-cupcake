import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/animations/emptycart.json",
              width: size.width * 0.45),
          Text(
            "your cart is empty",
            overflow: TextOverflow.fade,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.045,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
