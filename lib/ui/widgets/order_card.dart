import 'package:cackeapp/models/order_model.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usermodel.dart';

class OrderCard extends StatelessWidget {
  final Color mainColor = kPrimaryColordark;
  final OrderModel ordermodel;

  final Function() info;
  final Function() accept;
  const OrderCard({
    Key? key,
    required this.ordermodel,
    required this.info,
    required this.accept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var appuser = Provider.of<UserModel>(context);
    return Card(
      color: kPrimaryColorlight.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: SizedBox(
          width: size.width * 0.15,
          child: Image.network(
            ordermodel.items.first.item.imageurl,
          ),
        ),
        title: Text(
          ordermodel.orderID!,
          style: TextStyle(color: mainColor, fontSize: size.width * 0.03),
        ),
        subtitle: Row(
          children: [
            Expanded(child: Text("Rs ${ordermodel.total}")),
            Expanded(
                child: Text(
                    "Status:${ordermodel.iscomplete == true ? "Accepted" : "Pending"}")),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  info();
                },
                icon: const Icon(Icons.info)),
            appuser.role == "0"
                ? IconButton(
                    onPressed: () {
                      accept();
                    },
                    icon: const Icon(Icons.view_agenda))
                : Container(),
          ],
        ),
      ),
    );
  }
}
