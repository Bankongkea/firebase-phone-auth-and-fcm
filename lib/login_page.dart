import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_phone_auth/component/button_component.dart';
import 'package:flutter_firebase_phone_auth/component/text_component.dart';
import 'package:flutter_firebase_phone_auth/route_generator.dart';

import 'common/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneTextController = TextEditingController();

  @override
  void dispose() {
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/image/test.png', height: 250),
                  outlineTextField(_phoneTextController,
                      keyboardType: TextInputType.phone),
                  SizedBox(height: 20),
                  buttonRound(
                      onPressed: () {
                        validatePhone(_phoneTextController.text).then((value) {
                          if (value != null) {
                            Navigator.of(context).pushNamed(
                                Constant.VERIFY_CODE_PAGE,
                                arguments: value);
                          }
                        });
                      },
                      context: context,
                      buttonName: 'Login'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
