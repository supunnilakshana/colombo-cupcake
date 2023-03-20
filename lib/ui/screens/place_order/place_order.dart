// ignore_for_file: sort_child_properties_last

import 'dart:io';
import 'dart:typed_data';

import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/cart_item_model.dart';
import 'package:cackeapp/models/order_model.dart';
import 'package:cackeapp/models/usermodel.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/services/validator/validate_handeler.dart';
import 'package:cackeapp/ui/screens/member/home/home_screen.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  final List<CartItemModel> items;
  final UserModel user;
  final num total;
  const PlaceOrderScreen(
      {Key? key, required this.items, required this.total, required this.user})
      : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String _email = "";
  String _passWord = "";
  String _name = "";
  String _mobile = "";
  String _city = "";
  String _addr = "";
  String _emno = "";

  setUserData() async {
    if (mounted) {
      final user = widget.user;
      _namecon.text = user.name;
      _uncon.text = user.email;

      _mobilecon.text = user.phone;
    }

    setState(() {});
  }

  @override
  void initState() {
    setUserData();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _namecon = TextEditingController();
  final TextEditingController _mobilecon = TextEditingController();
  final TextEditingController _addrcon = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: kGradientbrown),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.02),
                const BackButton(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Place your order",
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                      SizedBox(
                        width: size.width,
                        child: Lottie.asset('assets/animations/placecake.json',
                            height: size.height * 0.3),
                      ),
                      Text(
                        "Total : ${widget.total}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: size.height * 0.01),
                    ],
                  ),
                ),
                const SizedBox(height: 1),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(83, 193, 164, 37),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _namecon,
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _uncon,
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildemail(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _mobilecon,
                                      onChanged: (value) {
                                        _mobile = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildmobile(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Mobile No",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      maxLines: 3,
                                      controller: _addrcon,
                                      onChanged: (value) {
                                        _addr = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Address",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  PopupDialog.loading(context);
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  final OrderModel orderModel = OrderModel(
                                      customerID: user!.uid,
                                      customerName: widget.user.name,
                                      items: widget.items,
                                      total: widget.total.toDouble(),
                                      iscomplete: false,
                                      customerAddr: _addrcon.text,
                                      customerEmail: _uncon.text,
                                      customerMobile: _mobilecon.text,
                                      createdAt: DateTime.now());
                                  final res = await FbHandeler.createDocAuto(
                                      orderModel.toMap(),
                                      CollectionPath.orderPath);
                                  Navigator.pop(context);
                                  if (res == resok) {
                                    Customtost.orderadd();
                                    // ignore: use_build_context_synchronously

                                    // ignore: use_build_context_synchronously
                                    PopupDialog.showPopupinfo(
                                      context,
                                      "Order Sccussfull",
                                      "Total :$widget.total",
                                    );
                                    // ignore: use_build_context_synchronously
                                    context.read<UserModel>().clearcart();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreenMember()));
                                  } else {
                                    Customtost.orderfail();
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: kPrimaryColordark),
                                child: const Center(
                                  child: Text(
                                    "Place Order",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
