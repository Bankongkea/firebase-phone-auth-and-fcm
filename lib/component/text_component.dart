
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget outlineTextField(String labelText, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}){
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText:labelText),
  );
}