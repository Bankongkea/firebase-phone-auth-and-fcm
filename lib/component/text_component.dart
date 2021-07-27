
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget outlineTextField(String labelText, TextEditingController controller, {TextInputType keyboardType = TextInputType.text, int maxLine = 1}){
  return TextField(
    controller: controller,
    maxLines: maxLine,
    keyboardType: keyboardType,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText:labelText),
  );
}