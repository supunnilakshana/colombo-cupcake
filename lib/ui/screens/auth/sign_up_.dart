import 'dart:io';
import 'dart:typed_data';

import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/usermodel.dart';
import 'package:cackeapp/services/auth/signin_mannager.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/services/validator/validate_handeler.dart';
import 'package:cackeapp/ui/screens/auth/check_signIn.dart';
import 'package:cackeapp/ui/screens/auth/sign_in.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/already_have_an_account_acheck.dart';
import 'package:cackeapp/ui/widgets/or_divider.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email = "";
  String _passWord = "";
  String _name = "";
  String _mobile = "";
  String _city = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _pwcon = TextEditingController();
  final TextEditingController _namecon = TextEditingController();
  final TextEditingController _mobilecon = TextEditingController();
  final TextEditingController _citycon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Hello !! ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
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
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(84, 167, 110, 17),
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
                                      controller: _namecon,
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Name ",
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
                                      controller: _uncon,
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildemail(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Email",
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
                                      controller: _mobilecon,
                                      onChanged: (value) {
                                        _mobile = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildmobile(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Mobile No ",
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
                                      obscureText: isHidepassword,
                                      controller: _pwcon,
                                      onChanged: (value) {
                                        _passWord = value;
                                      },
                                      validator: (value) {
                                        return Validater.signupPassword(value!);
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                              onTap: _viewPassword,
                                              child:
                                                  const Icon(Icons.visibility)),
                                          hintText: "Password ",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  print("press login");
                                  PopupDialog.loading(context);
                                  print(_email.trim());
                                  print(_passWord);

                                  int r = await SigninManager()
                                      .signUp(_email.trim(), _passWord);

                                  if (r == resok) {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    final umodel = UserModel(
                                        uid: user!.uid,
                                        name: _namecon.text,
                                        email: _uncon.text,
                                        phone: _mobilecon.text,
                                        role: UserRole.member.index.toString(),
                                        date: DateTime.now().toIso8601String());
                                    await FbHandeler.createDocManual(
                                        umodel.toMap(),
                                        CollectionPath.userpath,
                                        user.uid);

                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const CheckSignIn();
                                        },
                                      ),
                                    );
                                    print(r);
                                  } else if (r == resfail) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    Get.snackbar(
                                      "SignUp failed",
                                      "Please enter the valid email or password",
                                      icon: const Icon(Icons.error,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  } else if (r == 2) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    Get.snackbar(
                                      "SignUp failed",
                                      "Please enter the valid email or password",
                                      colorText: Colors.red,
                                      backgroundColor: Colors.yellow,
                                      icon: const Icon(Icons.error,
                                          color: Colors.black),
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                } else {
                                  print("Not Complete");
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
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            OrDivider(),
                            AlreadyHaveAnAccountCheck(
                              login: false,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SignIn();
                                    },
                                  ),
                                );
                              },
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

  bool isHidepassword = true;
  void _viewPassword() {
    if (isHidepassword == true) {
      isHidepassword = false;
    } else {
      isHidepassword = true;
    }
    setState(() {});
  }
}
