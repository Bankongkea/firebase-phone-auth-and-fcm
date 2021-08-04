import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/component/text_component.dart';

class DeliveryInfo extends StatefulWidget {
  final Function onChange;
  final userName;

  DeliveryInfo(this.userName, this.onChange);

  @override
  _DeliveryInfoState createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _nameController;

  _onApplyChange() async {
    widget.onChange(_nameController.text);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _nameController =
        TextEditingController(text: widget.userName);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text('បិទ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text('កែឈ្មោះ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  FlatButton(
                    child: Text('រក្សាទុក',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16)),
                    onPressed: _onApplyChange,
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Row(
              //   children: <Widget>[
              //     _buildTextField(_nameController, 'name'),
              //   ],
              // ),
              outlineTextField('បញ្ចូលឈ្មោះរបស់អ្នក', _nameController),
            ],
          ),
        ),
      ),
    );
  }
}
