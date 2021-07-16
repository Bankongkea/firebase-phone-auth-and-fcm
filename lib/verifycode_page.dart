import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/route_generator.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifyCodePage extends StatefulWidget {
  final dynamic _phoneNumberResult;

  const VerifyCodePage(this._phoneNumberResult);

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ផ្ទៀងផ្ទាត់លេខសម្ងាត់'),
      ),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => _pinPutFocusNode.unfocus(),
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'សូមចញ្ចូលលេខសម្ងាត់ដែលទទួលបានតាមលេខទូរស័ព្ទរបស់អ្នក ${widget._phoneNumberResult['national']}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(20.0),
                      child: PinPut(
                        fieldsCount: 6,
                        onSubmit: (String pin) {
                          _pinPutController.text = '';
                          signIn(pin);
                          /*_showSnackBar(pin, context)*/
                        },
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withOpacity(.5),
                          ),
                        ),
                      ),
                    ),
                    /*const SizedBox(height: 30.0),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => _pinPutFocusNode.requestFocus(),
                          child: const Text('Focus'),
                        ),
                        FlatButton(
                          onPressed: () => _pinPutFocusNode.unfocus(),
                          child: const Text('Unfocus'),
                        ),
                        FlatButton(
                          onPressed: () => _pinPutController.text = '',
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _verifyPhoneNumber() async {
    try {
      // dynamic parsed = await _plugin.parse(_phoneTextController.text, region: "KH");
      await _auth.verifyPhoneNumber(
        phoneNumber: widget._phoneNumberResult['e164'],
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await _auth.signInWithCredential(credential);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Constant.HOME_PAGE, (route) => false);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }

          // Handle other errors
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          _verificationId = verificationId;
          // String smsCode = pin;

          // Create a PhoneAuthCredential with the code
          /*PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _auth.signInWithCredential(credential);

          Navigator.of(context)
              .pushNamedAndRemoveUntil(Constant.HOME_PAGE, (route) => false);*/
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Constant.HOME_PAGE, (route) => false);
          print(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          // Auto-resolution timed out...
          print(verificationId);
        },
      );
    } catch (e) {
      print(e);
      // showSnackbar("Failed to Verify Phone Number: ${e}");
    }
  }
  Future<void> signIn(String otp) async {

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otp);

    // Sign the user in (or link) with the credential
    await _auth.signInWithCredential(credential);

  }

/*void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }*/
}
