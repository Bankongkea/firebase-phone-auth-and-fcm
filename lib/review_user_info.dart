import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewUserInfo extends StatefulWidget {
  @override
  _ReviewUserInfoState createState() => _ReviewUserInfoState();
}

class _ReviewUserInfoState extends State<ReviewUserInfo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ពិនិត្យព័ត៍មានរបស់អ្នក'),
      ),
      body: ListView(
        children: [_buildCardContact()],
      ),
    );
  }

  Widget _buildCardContact() {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text('1'),
                  ),
                  SizedBox(width: 16),
                  Text('ព័ត៍មានរបស់អ្នក',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        //minWidth: 50,
                        child: Text('ប្ដូរឈ្មោះ',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('ឈ្មោះ'),
                      SizedBox(height: 4),
                      Text(_auth.currentUser.displayName ?? 'មិនមានឈ្មោះ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('លេខទូរស័ព្ទ'),
                      SizedBox(height: 4),
                      Text(_auth.currentUser.phoneNumber,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
