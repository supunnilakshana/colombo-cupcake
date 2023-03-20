// ignore_for_file: unnecessary_const

import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/cart_item_model.dart';
import 'package:cackeapp/models/order_model.dart';
import 'package:cackeapp/models/usermodel.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/ui/screens/place_order/place_order.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/emptycart.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItemModel> cartlist = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  num total = 0.0;
  num discount = 0.0;
  bool discountstatus = false;
  bool ispress = false;
  @override
  void initState() {
    super.initState();
  }

  static var screenHeight;
  static var screenWidth;
  @override
  Widget build(BuildContext context) {
    total = 0.0;

    var cpmodel = Provider.of<UserModel>(context);
    cartlist = Provider.of<UserModel>(context).cart;
    for (var element in cartlist) {
      total = total + (element.item.price * element.qty);
    }
    print(total);

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (cartlist.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: EmptyCart(),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton.extended(
        //     icon: const Icon(Icons.shopping_cart_checkout_rounded),
        //     backgroundColor: appcolor,
        //     onPressed: () {},
        //     label: const Text("Checkout")),
        body: SafeArea(
            child: SizedBox(
          height: screenHeight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "My Cart",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(top: 5),
                height: 35,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "You have ${cartlist.length} items in your cart",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: ListView.builder(
                      itemCount: cartlist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: posCartCard(
                              index: index,
                              screenHeight: screenHeight,
                              name: cartlist[index].item.name,
                              price: cartlist[index].item.price,
                              quantity: cartlist[index].qty,
                              imageURL: cartlist[index].item.imageurl),
                        );
                      })),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        const Divider(
                          height: 10,
                          thickness: 5,
                          color: Color(0xffd17842),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 25),
                            ),
                            Text(
                              "LKR ${total.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 25),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (cartlist.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceOrderScreen(
                                      user: cpmodel,
                                      items: cartlist,
                                      total: total)));

                          // PopupDialog.loading(context);
                          // final user = FirebaseAuth.instance.currentUser;
                          // final OrderModel orderModel = OrderModel(
                          //     customerID: user!.uid,
                          //     customerName: cpmodel.name,
                          //     items: cartlist,
                          //     total: total.toDouble(),
                          //     iscomplete: false,
                          //     createdAt: DateTime.now());
                          // final res = await FbHandeler.createDocAuto(
                          //     orderModel.toMap(), CollectionPath.orderPath);
                          // Navigator.pop(context);
                          // if (res == resok) {
                          //   Customtost.orderadd();
                          //   // ignore: use_build_context_synchronously

                          //   PopupDialog.showPopupinfo(
                          //     context,
                          //     "Order Sccussfull",
                          //     "Total :$total",
                          //   );
                          //   context.read<UserModel>().clearcart();
                          // } else {
                          //   Customtost.orderfail();
                          // }
                        }
                      },
                      minWidth: 150,
                      height: screenHeight * 0.06,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: appcolor,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Place Order!",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
      );
    }
  }
}

// ignore: camel_case_types
class posCartCard extends StatelessWidget {
  final int index;
  final screenHeight;
  final String imageURL;
  final String name;
  final num price;
  final num quantity;

  const posCartCard({
    Key? key,
    required this.screenHeight,
    required this.imageURL,
    required this.name,
    required this.price,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: screenHeight * 0.2 - 30,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kPrimaryColorlight,
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.0,
                          spreadRadius: 0.5,
                          color: kPrimaryColordark.withOpacity(0.5),
                        ),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageURL),
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<UserModel>().removecartitem(index);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "\Rs\t",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffd17842),
                              ),
                            ),
                            Text(
                              price.toStringAsFixed(2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (() {
                                context.read<UserModel>().additemcount(index);
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appcolor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(Icons.add,
                                    size: 30, color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: (() {
                                context
                                    .read<UserModel>()
                                    .removeitemcount(index);
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appcolor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(Icons.remove,
                                    size: 30, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
