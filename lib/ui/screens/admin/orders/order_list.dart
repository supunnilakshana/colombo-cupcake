import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/order_model.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/ui/widgets/errorpage.dart';
import 'package:cackeapp/ui/widgets/order_card.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  late Future<List<OrderModel>> futureData;

  loadData() {
    futureData = FbHandeler.getOrders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Orders"),
        automaticallyImplyLeading: false,
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
                          "Order id :${itemData.orderID}\nCustomer name :${itemData.customerName}\nCustomer Email :${itemData.customerEmail}\nCustomer Mobile :${itemData.customerEmail}\nCustomer Address :${itemData.customerAddr}\nItems :\n$items\nTotal:${itemData.total} ");
                    },
                    accept: () {
                      PopupDialog.showPopupDilog(
                          context,
                          "Are you sure to accept this order ?",
                          "Order id :${itemData.orderID}\nCustomer name :${itemData.customerName}\nCustomer Email :${itemData.customerEmail}\nCustomer Mobile :${itemData.customerEmail}\nCustomer Address :${itemData.customerAddr}\nItems :\n$items\nTotal:${itemData.total} ",
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
