import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cackeapp/ui/styles/app_styles.dart';

import 'package:flutter/material.dart';

class PopupDialog {
  static Future loading(
    BuildContext context, {
    bool dismissible = true,
    bool autoDismiss = false,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (context) => Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                      color: kPrimaryColordark,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ));
  }

  static showPopupDilog(BuildContext context, String titel, String description,
      Function actionFun) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            title: titel,
            desc: description,
            btnCancelText: "Cancel",
            btnOkText: "Accept",
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              actionFun();
            },
            btnOkColor: kPrimaryColordark,
            btnCancelColor: Colors.grey)
        .show();
  }

  static showPopupWarning(BuildContext context, String titel,
      String description, Function actionFun) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      desc: description,
      btnCancelText: "No",
      btnOkText: "Yes",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        actionFun();
      },
    ).show();
  }

  static showPopuplogout(BuildContext context, String titel, String description,
      Function actionFun) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      desc: description,
      btnCancelText: "No",
      btnOkText: "Yes",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        actionFun();
      },
    ).show();
  }

  static showPopupErorr(
    BuildContext context,
    String titel,
    String description,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      desc: description,
      btnOkText: "Ok",
      btnCancel: null,
      btnOkOnPress: () {},
    ).show();
  }

  static showPopupinfo(
    BuildContext context,
    String titel,
    String description,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: titel,
      desc: description,
      btnOkText: "Ok",
      btnCancel: null,
      btnOkOnPress: () {},
    ).show();
  }
}

























/*static Future<void> showMyDialog(BuildContext context, String titel,
      String description, Function actionFun) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titel),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes , did'),
              onPressed: () {
                /// actionFun();
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.LEFTSLIDE,
                  title: 'Dialog Title',
                  desc: 'Dialog description here.............',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                )..show();
              },
            ),
            TextButton(
              child: const Text('Not yet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } */