import 'package:cackeapp/services/validator/validate_handeler.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../ui/styles/app_styles.dart';
import '../ui/widgets/already_have_an_account_acheck.dart';
import '../ui/widgets/or_divider.dart';

class SignIna extends StatefulWidget {
  const SignIna({Key? key}) : super(key: key);

  @override
  State<SignIna> createState() => _SignInaState();
}

class _SignInaState extends State<SignIna> {
  String _email = "";
  String _passWord = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _pwcon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const SelectLang();
                        //     },
                        //   ),
                        // );
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.language_outlined,
                            size: 26,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Change Language",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SizedBox(
                        width: size.width,
                        child: Lottie.asset('assets/animations/error.json',
                            height: size.height * 0.3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(85, 25, 167, 17),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
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
                                          hintText: "Email or Mobile No *",
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
                                      obscureText: true,
                                      controller: _pwcon,
                                      onChanged: (value) {
                                        _passWord = value;
                                      },
                                      validator: (value) {
                                        return Validater.signupPassword(value!);
                                      },
                                      decoration: const InputDecoration(
                                          suffixIcon: Icon(Icons.visibility),
                                          hintText: "Password *",
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
                              onTap: (() {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return const ForgotPassword();
                                //     },
                                //   ),
                                // );
                              }),
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  // print("press login");
                                  // print(_email.trim());
                                  // print(_passWord);
                                  // int r = await SigninManager()
                                  //     .signIn(_email.trim(), _passWord);
                                  // print(r.toString() +
                                  //     "------------------------------------------");
                                  // if (r == resok) {
                                  //   print("loged");
                                  //   // ignore: use_build_context_synchronously
                                  //   Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) {
                                  //         return const CheckSignIn();
                                  //       },
                                  //     ),
                                  //   );
                                  // } else if (r == resfail) {
                                  //   Get.snackbar(
                                  //     "Signin failed",
                                  //     "Please enter the correct email or password",
                                  //     backgroundColor: Colors.red,
                                  //     icon: const Icon(Icons.error,
                                  //         color: Colors.white),
                                  //     snackPosition: SnackPosition.BOTTOM,
                                  //   );
                                  // } else if (r == resfail) {
                                  //   Get.snackbar(
                                  //     "Signin failed",
                                  //     "Please enter the correct email or password",
                                  //     colorText: Colors.red,
                                  //     backgroundColor: Colors.yellow,
                                  //     icon: const Icon(Icons.error,
                                  //         color: Colors.black),
                                  //     snackPosition: SnackPosition.TOP,
                                  //   );
                                  // }
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
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            OrDivider(),
                            AlreadyHaveAnAccountCheck(
                              login: true,
                              press: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return SelectUserScreen();
                                //     },
                                //   ),
                                // );
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
}
