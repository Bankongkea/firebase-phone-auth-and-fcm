
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget outlineTextField(TextEditingController controller, {TextInputType keyboardType = TextInputType.text}){
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'បញ្ចូលលេខទូរស័ព្ទរបស់អ្នក'),
  );
}