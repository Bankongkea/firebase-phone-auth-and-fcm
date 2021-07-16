

import 'package:flutter/material.dart';

Widget buttonRound({BuildContext context, String buttonName, @required VoidCallback onPressed}){
  return Container(
    width: double.infinity,
    child: ElevatedButton(
        child: Text(buttonName.toUpperCase(),
            style: TextStyle(fontSize: 14)),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
            foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(4.0)),
            ))),
        onPressed: onPressed),
  );
}