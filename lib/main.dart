import 'package:cackeapp/models/usermodel.dart';
import 'package:cackeapp/ui/screens/splash_screen/splash_screen.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            UserModel(name: "", email: "", phone: "", role: "-1", date: ""),
        builder: (BuildContext context, child) {
          return GetMaterialApp(
            title: 'Colombo cupcake',
            theme: ThemeData(
                primarySwatch: appcolor,
                textTheme: GoogleFonts.robotoTextTheme(
                  Theme.of(context).textTheme,
                )),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        });
  }
}
