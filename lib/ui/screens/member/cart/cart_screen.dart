// ignore_for_file: unnecessary_const

import 'package:cackeapp/models/cart_item_model.dart';
import 'package:cackeapp/models/usermodel.dart';
import 'package:cackeapp/ui/widgets/emptycart.dart';
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
        body: SafeArea(
            child: Container(
          height: screenHeight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "My Cart",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(top: 5),
                height: 35,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff17191f)),
                child: Text(
                  "You have ${cartlist.length} items in your cart",
                  style: const TextStyle(
                    color: Colors.white,
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
                        return posCartCard(
                            index: index,
                            screenHeight: screenHeight,
                            name: cartlist[index].item.name,
                            price: cartlist[index].item.price,
                            quantity: cartlist[index].qty,
                            imageURL: cartlist[index].item.imageurl);
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
                            const Text(
                              "Total",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            Text(
                              "LKR ${total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      // try {
                      //   setState(() {
                      //     ispress = true;
                      //   });
                      //   _scaffoldKey.currentState!

                      //       // ignore: deprecated_member_use
                      //       .showSnackBar(SnackBar(
                      //     duration: const Duration(seconds: 4),
                      //     backgroundColor: Colors.brown,
                      //     content: Row(
                      //       children: const <Widget>[
                      //         CircularProgressIndicator(),
                      //         Text("processing...")
                      //       ],
                      //     ),
                      //   ));
                      //   List<CartItemModel> tempcartlist = [];
                      //   final user = FirebaseAuth.instance.currentUser;
                      //   BakeryItemModel tempbitem;

                      //   for (var element in cartlist) {
                      //     if (element.itemtype == ItemType.bakery) {
                      //       tempbitem = await DbHandeler.getBakeryItem(
                      //           element.id);

                      //       if (tempbitem.QTY != 0) {
                      //         tempbitem.QTY = tempbitem.QTY - element.qty;
                      //         await DbHandeler.updateDoc(
                      //             tempbitem.toMap(),
                      //             CollectionPath.bakeryitempath,
                      //             tempbitem.bID!);
                      //         await DbHandeler.setReorderbakeryAuto(
                      //             tempbitem);

                      //         tempcartlist.add(element);
                      //       } else {}
                      //     } else {
                      //       tempcartlist.add(element);
                      //     }
                      //   }
                      //   OrderModel orderModel = OrderModel(
                      //       date: Date.getStringdatenow(),
                      //       customerID: cpmodel.phone,
                      //       cashierID: user!.uid,
                      //       customerName: cpmodel.name,
                      //       items: tempcartlist,
                      //       discount: discount,
                      //       totalPrice: total - discount,
                      //       createdAt: DateTime.now());

                      //   int res = await DbHandeler.createDocAuto(
                      //       orderModel.toMap(), CollectionPath.orderpath);
                      //   if (res == resok) {
                      //     print("order create");
                      //     context.read<UserModel>().clearcart();
                      //     Customtost.commontost(
                      //         "order created", Colors.green);
                      //     Navigator.push(context,
                      //         CupertinoPageRoute(builder: (context) {
                      //       return OrderSuccess(
                      //         customerModel: cpmodel,
                      //         total: total - discount,
                      //       );
                      //     }));
                      //   } else {
                      //     Customtost.commontost(
                      //         "Action failed", Colors.red);
                      //   }

                      //   setState(() {
                      //     ispress = false;
                      //   });
                      // } on Exception catch (e) {
                      //   print(e);
                      //   setState(() {
                      //     ispress = false;
                      //   });
                      // }
                    },
                    minWidth: 150,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color(0xffd17842),
                    child: const Text(
                      "Place Order!",
                      style: TextStyle(
                        color: Colors.white,
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
              color: const Color(0xff171b22),
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                          color: Color(0xff30221f),
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
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xffaeaeae),
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
                              price.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                                  color: const Color.fromARGB(255, 82, 77, 71),
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
                                  color: Colors.white,
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
                                  color: const Color.fromARGB(255, 82, 77, 71),
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
