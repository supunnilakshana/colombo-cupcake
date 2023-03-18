import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/category_model.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/services/validator/validate_handeler.dart';
import 'package:cackeapp/ui/screens/admin/category/category_list.dart';
import 'package:cackeapp/ui/screens/admin/home/home_screen.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:cackeapp/ui/widgets/tots.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatCategoryScreen extends StatefulWidget {
  const CreatCategoryScreen({Key? key}) : super(key: key);

  @override
  State<CreatCategoryScreen> createState() => _CreatCategoryScreenState();
}

class _CreatCategoryScreenState extends State<CreatCategoryScreen> {
  String _titel = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titelcon = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

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
              children: [
                SizedBox(height: size.height * 0.02),
                BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomeScreenAdmin();
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 2, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create a cake category",
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                      const SizedBox(
                        height: 10,
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
                              height: 25,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(84, 165, 167, 17),
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
                                      controller: _titelcon,
                                      onChanged: (value) {
                                        _titel = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Category",
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
                                  final cat =
                                      CategoryModel(name: _titelcon.text);
                                  PopupDialog.loading(context);
                                  int r = await FbHandeler.createDocAuto(
                                    cat.toMap(),
                                    CollectionPath.categorypath,
                                  );

                                  if (r == resok) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const CategoryScreen();
                                        },
                                      ),
                                    );
                                    Customtost.commontost(
                                        "Succussfully created", Colors.green);
                                  } else if (r == resfail) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    Get.snackbar(
                                      "Somthing went wromg",
                                      "Please try again",
                                      colorText: Colors.red,
                                      backgroundColor: Colors.yellow,
                                      icon: const Icon(Icons.error,
                                          color: Colors.black),
                                      snackPosition: SnackPosition.BOTTOM,
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
                                    "Create",
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
