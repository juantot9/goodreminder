import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:good_reminder/utils/colors.dart';

enum kMoreOptionsKeys {
  clearAll,
  logOut
}

Map<int, String> kMoreOptionsMap = {
  kMoreOptionsKeys.clearAll.index: 'Borrar los hechos',
  kMoreOptionsKeys.logOut.index: 'Cerrar sesión'
};

class Utils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  static void showCustomDialog(BuildContext context,
      {String title,
      String msg,
      String noBtnTitle: 'Cerrar',
      Function onConfirm,
      String confirmBtnTitle: 'Sí'}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        if (onConfirm != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(TodosColor.kPrimaryColorCode)),
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: Text(
              confirmBtnTitle,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary:Color(TodosColor.kSecondaryColorCode)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            noBtnTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }
}
