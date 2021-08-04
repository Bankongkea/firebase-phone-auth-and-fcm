
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart';

Future<dynamic> validatePhone(String phone) async {

  PhoneNumber _plugin = PhoneNumber();
  if (phone.trim().length == 0) {
    return null;
  } else {
    String platformVersion;
    try {
      final parsed = await _plugin.parse(phone, region: "KH");
      platformVersion = """\n
        type: ${parsed['type']}
        e164: ${parsed['e164']} 
        international: ${parsed['international']}
        national: ${parsed['national']}
        """;
      print('$platformVersion');
      return parsed;
    } on PlatformException catch (e) {
      platformVersion = 'Failed to get platform version. ${e.message}';
       print('$platformVersion');
      return null;
    }
  }
}

Widget _noOrderRecord(String msg) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/image/shopping_empty.png',
          width: 220.0,
          height: 220.0,
        ),
        Text(
          msg,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 70.0,
        ),
      ],
    ),
  );
}

showMessage(String message, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text('យល់ព្រម'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('ដំណឹង'),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}