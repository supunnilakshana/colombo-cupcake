import 'package:cackeapp/config/initdata.dart';
import 'package:cackeapp/models/usermodel.dart';
import 'package:cackeapp/services/firebase/fb_handeler.dart';
import 'package:cackeapp/ui/screens/admin/home/home_screen.dart';
import 'package:cackeapp/ui/screens/member/home/home_screen.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:cackeapp/ui/widgets/errorpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadUserData extends StatefulWidget {
  const LoadUserData({
    Key? key,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LoadUserDataState createState() => _LoadUserDataState();
}

class _LoadUserDataState extends State<LoadUserData> {
  late Future<UserModel> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FbHandeler.getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData) {
          UserModel data = snapshot.data as UserModel;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<UserModel>().updateData(data);
          });
          if (int.parse(data.role) == UserRole.admin.index) {
            return const HomeScreenAdmin();
          } else {
            return const HomeScreenMember();
          }
        } else if (snapshot.hasError) {
          return Errorpage(size: size.width * 0.7);
        }
        // By default show a loading spinner.
        return Scaffold(
          backgroundColor: kPrimaryColorlight,
          body: Center(child: getLoadinganimi(size)),
        );
      },
    );
  }

  loaddata() async {
    futureData = FbHandeler.getUser();
    setState(() {});
  }
}
