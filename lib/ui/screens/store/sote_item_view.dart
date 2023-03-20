import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/cart_item_model.dart';
import 'package:cackeapp/models/order_model.dart';
import 'package:cackeapp/models/product_model.dart';
import 'package:cackeapp/models/usermodel.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/ui/screens/place_order/place_order.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreItemView extends StatefulWidget {
  const StoreItemView({
    Key? key,
    required this.productmodel,
  }) : super(key: key);

  final ProductModel productmodel;

  @override
  _StoreItemViewState createState() => _StoreItemViewState();
}

class _StoreItemViewState extends State<StoreItemView> {
  double total = 0.0;
  int itemquantity = 1;
  bool isdiscount = false;
  @override
  Widget build(BuildContext context) {
    var cpmodel = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;
    // if (widget.discount > 0) {
    //   isdiscount = true;
    // } else {
    //   isdiscount = false;
    // }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Wrap(
          //will break to another line on overflow
          direction: Axis.horizontal, //use vertical to show  on vertical axis
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton.extended(
                    heroTag: "btn1",
                    backgroundColor: Colors.green,
                    onPressed: () async {
                      var citem = [
                        CartItemModel(
                            id: widget.productmodel.id!,
                            item: widget.productmodel,
                            qty: itemquantity)
                      ];
                      print("pressed");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlaceOrderScreen(
                                  user: cpmodel, items: citem, total: total)));

                      // PopupDialog.loading(context);
                      // final user = FirebaseAuth.instance.currentUser;

                      // final OrderModel orderModel = OrderModel(
                      //     customerID: user!.uid,
                      //     customerName: cpmodel.name,
                      //     items: citem,
                      //     total: widget.productmodel.price,
                      //     iscomplete: false,
                      //     createdAt: DateTime.now());
                      // final res = await FbHandeler.createDocAuto(
                      //     orderModel.toMap(), CollectionPath.orderPath);
                      // Navigator.pop(context);
                      // if (res == resok) {
                      //   Customtost.orderadd();
                      //   // ignore: use_build_context_synchronously

                      //   // ignore: use_build_context_synchronously
                      //   PopupDialog.showPopupinfo(
                      //     context,
                      //     "Order Sccussfull",
                      //     "Total :${widget.productmodel.price.toDouble() * itemquantity}",
                      //   );
                      // } else {
                      //   Customtost.orderfail();
                      // }
                    },
                    label: const Text("Order Now"))),
            // button third//button first

            // button second

            Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton.extended(
                    heroTag: "btn2",
                    backgroundColor: appcolor,
                    onPressed: () async {
                      context.read<UserModel>().addcart(CartItemModel(
                          id: widget.productmodel.id!,
                          item: widget.productmodel,
                          qty: itemquantity));
                      Customtost.cartadd();
                    },
                    label: const Text("Add to cart"))),
            // button third

            // Add more buttons here
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
                width: size.width,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.productmodel.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kPrimaryColordark,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.06),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                      boxShadow: [
                        // BoxShadow(
                        //   blurRadius: 1.0,
                        //   spreadRadius: 0.5,
                        //   color: kPrimaryColordark.withOpacity(0.5),
                        // ),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.productmodel.imageurl),
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
                width: size.width,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        "Rs. ${widget.productmodel.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05),
                      ),
                    ),
                    Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        "Category : " + widget.productmodel.category.name,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        )),
                  ]),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(widget.productmodel.context,
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                  ),
                  Text("Quantity  ",
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      )),
                  Container(
                    width: size.width * 0.19,
                    padding: EdgeInsets.all(size.width * 0.007),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * 0.01),
                        color: appcolor),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (itemquantity > 0) {
                                setState(() {
                                  itemquantity--;
                                });
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: size.width * 0.04,
                            )),
                        Container(
                          width: size.width * 0.075,
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.007),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.007,
                              vertical: size.width * 0.005),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.007),
                              color: Colors.white),
                          child: Text(
                            itemquantity.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.04),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              if (itemquantity < 100) {
                                setState(() {
                                  itemquantity++;
                                });
                              }
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: size.width * 0.04,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ));
  }
}
