import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/common/route_generator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: FutureBuilder(
        future: _users.doc(_auth.currentUser.phoneNumber).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something Error'),
            );
          }
          if (snapshot.hasData && !snapshot.data.exists) {
            return Center(
              child: Text("Document does not exist"),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return body(snapshot);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget body(snapshot) {
    Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'ព័ត៍មានរបស់អ្នក',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: () => null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                FontAwesomeIcons.solidEdit,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/profile.png')),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ឈ្មោះ :',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            data['user_name'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'លេខទូរស័ព្ទ :',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            data['phone_number'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text('ចាកចេញ'),
                leading: Icon(FontAwesomeIcons.envelope),
              ),
              ListTile(
                title: Text('ចាកចេញ'),
                leading: Icon(FontAwesomeIcons.child),
              ),
              ListTile(
                title: Text('ចាកចេញ'),
                leading: Icon(FontAwesomeIcons.shoppingCart),
              ),
              ListTile(
                title: Text('ចាកចេញ'),
                leading: Icon(FontAwesomeIcons.doorOpen),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Constant.LOGIN_PAGE);
                  _auth
                      .signOut()
                      .then((value) => Navigator.of(context)
                          .pushReplacementNamed(Constant.LOGIN_PAGE))
                      .catchError((onError) {});
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
