import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/category_model.dart';
import 'package:cackeapp/models/order_model.dart';
import 'package:cackeapp/models/product_model.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/ui/screens/admin/category/add_category.dart';
import 'package:cackeapp/ui/screens/admin/home/home_screen.dart';
import 'package:cackeapp/ui/screens/admin/products/addnew_producrs.dart';
import 'package:cackeapp/ui/screens/admin/products/edit_products.dart';
import 'package:cackeapp/ui/screens/member/home/home_screen.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/category_card.dart';
import 'package:cackeapp/ui/widgets/errorpage.dart';
import 'package:cackeapp/ui/widgets/order_card.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/product_card.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  late Future<List<OrderModel>> futureData;

  loadData() {
    futureData = FbHandeler.getMyOrders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("My Orders"),
        leading: BackButton(
          color: kPrimaryColordark,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomeScreenMember();
                },
              ),
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> data = snapshot.data as List<OrderModel>;
            print(data);
            if (data.isNotEmpty) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var itemData = data[index];
                  String items = "";
                  for (var element in itemData.items) {
                    items += "\n\t${element.item.name} x ${element.qty}";
                  }
                  return OrderCard(
                    ordermodel: itemData,
                    info: () {
                      PopupDialog.showPopupinfo(context, "Order Details",
                          "Order id :${itemData.orderID}\nCustomer name :${itemData.customerName}\nItems :\n$items\nTotal:${itemData.total} ");
                    },
                    accept: () {
                      PopupDialog.showPopupDilog(
                          context,
                          "Are you sure to accept this order ?",
                          "Order id :${itemData.orderID}\nCustomer name :${itemData.customerName}\nItems :\n$items\nTotal:${itemData.total} ",
                          () async {
                        var om = itemData;
                        om.iscomplete = true;
                        int res = await FbHandeler.updateDoc(
                            om.toMap(), CollectionPath.orderPath, om.orderID!);
                        if (res == resok) {
                          Customtost.commontost(
                              "Succussfully updated ", Colors.green);
                        } else {
                          Customtost.commontost("Failed ", Colors.red);
                        }
                        setState(() {});
                      });
                    },
                  );
                },
              );
            } else {
              return Center(
                  child: Lottie.asset("assets/animations/emptybox.json",
                      width: size.width * 0.6));
            }
          } else if (snapshot.hasError) {
            return Errorpage(size: size.width * 0.7);
          }

          return Center(child: getLoadinganimi(size));
        },
      ),
    );
  }
}
