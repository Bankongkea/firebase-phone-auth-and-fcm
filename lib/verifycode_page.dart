import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/common/route_generator.dart';
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
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  CollectionReference users = FirebaseFirestore.instance.collection('user');

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
      key: _scaffoldKey,
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
                      'សូមចញ្ចូលលេខសម្ងាត់ដែលទទួលបានតាមលេខទូរស័ព្ទរបស់អ្នក ${widget
                          ._phoneNumberResult['national']}',
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
                          _signInWithPhoneNumber(pin);
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> addUser(String phoneNumber,) {
    return users.doc(phoneNumber)
        .set({
      'phone_number': phoneNumber,
      'user_name': 'គ្មានឈ្មោះ',
      'order_number': 0,
      'profile_url': ''
    });
  }

  void _verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      final User user =
          (await _auth.signInWithCredential(phoneAuthCredential)).user;
      // users
      //     .doc(user.phoneNumber)
      //     .get()
      //     .then((DocumentSnapshot documentSnapshot) {
      //   if (documentSnapshot.exists) {
      //     var name = documentSnapshot.data()['user_name'];
      //     print('name ; $name');
      //   } else {}
      // });
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Constant.HOME_PAGE, (route) => false);
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      // setState(() {
      //   _message =
      //       'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      // });
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: widget._phoneNumberResult['e164'],
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      _showDialog("Failed to Verify Phone Number", context);
    }
  }

  void _signInWithPhoneNumber(String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      final User user = (await _auth.signInWithCredential(credential)).user;
      users
          .doc(user.phoneNumber)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var name = documentSnapshot.data()['user_name'];
          print('name ; $name');
        } else {
          addUser(user.phoneNumber).then((value) {
            print('phone ');
          })
              .catchError((error) => print("Failed to add user: $error"));
        }
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Constant.HOME_PAGE, (route) => false);
    } catch (e) {
      print(e);
      _showDialog("Failed to sign in", context);
    }
  }
}

_showDialog(String message, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text('យល់'),
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
