import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/component/delivery_info.dart';

import 'common/route_generator.dart';

class ReviewUserInfoPage extends StatefulWidget {
  @override
  _ReviewUserInfoPageState createState() => _ReviewUserInfoPageState();
}

class _ReviewUserInfoPageState extends State<ReviewUserInfoPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ពិនិត្យព័ត៍មានរបស់អ្នក'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              _buildCardContact(),
              _buildCardAddress(),
            ],
          ),
          _isLoading == true
              ? Center(child: CircularProgressIndicator())
              : SizedBox()
        ],
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
                        child: Text('ប្ដូរឈ្មោះ',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)),
                        onPressed: () {
                          _showContactInfo();
                        },
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
                        Text(
                            _auth.currentUser.displayName == ''
                                ? 'មិនមានឈ្មោះ'
                                : _auth.currentUser.displayName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('លេខទូរស័ព្ទ'),
                        SizedBox(height: 4),
                        Text(_auth.currentUser.phoneNumber,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardAddress() {
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
                  Text('ព័ត៍មានទីតាំងរបស់អ្នក',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        child: Text('ប្ដូរឈ្មោះ',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)),
                        onPressed: () {
                          Navigator.of(context).pushNamed(Constant.MAP_VIEW_PAGE);//_showContactInfo();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('ទីតាំង'),
                  SizedBox(height: 4),
                  Text(
                      _auth.currentUser.displayName == ''
                          ? 'មិនមានឈ្មោះ'
                          : _auth.currentUser.displayName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('ព័ត៍មានបន្ងែមលើទីតាំងរបស់អ្នក'),
                  SizedBox(height: 4),
                  Text(_auth.currentUser.phoneNumber,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showContactInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DeliveryInfo(_onChangeContact);
      },
    );
  }

  _onChangeContact(String name) async {
    setState(() {
      _isLoading = true;
    });
    await _auth.currentUser.updateProfile(displayName: name);
    await _auth.currentUser.reload();
    setState(() {
      _isLoading = false;
    });
  }
}
