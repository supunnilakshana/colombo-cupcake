import 'package:cackeapp/models/usermodel.dart';
import 'package:cackeapp/services/auth/signin_mannager.dart';
import 'package:cackeapp/ui/screens/admin/category/category_list.dart';
import 'package:cackeapp/ui/screens/admin/home/home_screen.dart';
import 'package:cackeapp/ui/screens/admin/products/addnew_producrs.dart';
import 'package:cackeapp/ui/screens/admin/products/product_list.dart';
import 'package:cackeapp/ui/screens/auth/sign_in.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/popup_dilog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MemberDrawer extends StatelessWidget {
  MemberDrawer({
    Key? key,
  }) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var userModel = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: kDefaultIconLightColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: kPrimaryColorlight),
                accountEmail: Text(user!.email.toString()),
                accountName: Text(userModel.name),
                currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"))),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: kPrimaryColordark,
                ),
                title: const Text('Home'),
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreenAdmin()));
                },
              ),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.list_rounded,
                  color: kPrimaryColordark,
                ),
                title: const Text('My Orders'),
                onTap: () async {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const MyAdsScreen()));
                },
              ),
            ),

            // Card(
            //   elevation: 0,
            //   child: ListTile(
            //     leading: const Icon(
            //       Icons.web,
            //       color: kPrimaryColordark,
            //     ),
            //     title: const Text('About Us'),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const AboutUsScreen()));
            //     },
            //   ),
            // ),
            // Card(
            //   elevation: 0,
            //   child: ListTile(
            //     leading: const Icon(
            //       Icons.contact_page_outlined,
            //       color: kPrimaryColordark,
            //     ),
            //     title: const Text('Contact Us'),
            //     onTap: () async {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const ContactUsScreen()));
            //     },
            //   ),
            // ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: kPrimaryColordark,
                ),
                title: const Text('Logout'),
                onTap: () {
                  PopupDialog.showPopuplogout(
                      context, "Signout", "Do you want to signout ? ",
                      () async {
                    context.read<UserModel>().updateData(UserModel(
                        name: "", email: "", phone: "", role: "-1", date: ""));

                    await SigninManager().signOut();

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                    print("logingout");
                  });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
