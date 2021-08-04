import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_phone_auth/component/delivery_info.dart';
import 'package:flutter_firebase_phone_auth/model/address.dart';
import 'package:flutter_firebase_phone_auth/model/status_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/route_generator.dart';
import 'component/text_component.dart';
import 'model/order.dart';
import 'model/product.dart';

class ReviewUserInfoPage extends StatefulWidget {
  final Product _product;
  final int _qty;

  ReviewUserInfoPage(this._product, this._qty);

  @override
  _ReviewUserInfoPageState createState() => _ReviewUserInfoPageState();
}

class _ReviewUserInfoPageState extends State<ReviewUserInfoPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('user');
  bool _isLoading = false;
  TextEditingController _addressNoteController;
  AddressObj _address = AddressObj();
  int price;
  int totalPrice;

  @override
  void initState() {
    _addressNoteController = TextEditingController();
    SharedPreferences.getInstance().then((value) {
      _address.lat = value.get('lat');
      _address.lng = value.get('lng');
      _address.addressName = value.get('addressName');
      _address.addressNote = value.get('addressNote');
      _addressNoteController.text = _address.addressNote;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _addressNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ពិនិត្យព័ត៍មានរបស់អ្នក'),
      ),
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildCardProduct(),
              _buildCardContact(data),
              _buildCardAddress(),
              SizedBox(
                height: 20,
              ),
              _buildNextButton()
            ],
          ),
          _isLoading == true
              ? Center(child: CircularProgressIndicator())
              : SizedBox(),
          /*Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: _buildNextButton(),
            ),*/
        ],
      ),
    );
  }

  Widget _buildCardContact(data) {
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
                    child: Text('2'),
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
                          _showContactInfo(data['user_name']);
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
                        Text(data['user_name'],
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
                        Text(data['phone_number'],
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
                    child: Text('3'),
                  ),
                  SizedBox(width: 16),
                  Text('ព័ត៍មានទីតាំងរបស់អ្នក',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        child: Text('កំណត់ទីតាំងដឹក',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)),
                        onPressed: () async {
                          var address = await Navigator.of(context).pushNamed(
                              Constant.MAP_VIEW_PAGE); //_showContactInfo();
                          if (address != null) {
                            setState(() {
                              _address = address;
                            });
                          }
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
                      _address.addressName == null
                          ? 'មិនទាន់មានទីតាំង'
                          : _address.addressName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('ព័ត៍មានបន្ងែមលើទីតាំងរបស់អ្នក'),
                  SizedBox(height: 4),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, bottom: 16, right: 16),
                    child: outlineTextField('បញ្ចូលព័ត៍មានខ្លះសម្រាប់អ្នកដឹក',
                        _addressNoteController,
                        maxLine: 2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardProduct() {
    price = int.parse(widget._product.price.toString());
    totalPrice = (price * widget._qty) + 8000;
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 16.0, right: 16, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text('1'),
                ),
                SizedBox(width: 16),
                Text(
                  widget._product.name,
                  maxLines: 2,
                  //softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  widget._qty.toString() + 'x',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 16.0),
                Image(
                  height: 150,
                  width: 150,
                  image: CachedNetworkImageProvider(widget._product.image),
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8),
                      Text(
                        'តម្លៃ ' +
                            widget._product.price +
                            '' +
                            widget._product.currency,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18),
                      ),
                      Text('តម្លៃសេវាដឹកជញ្ជូន 8000រៀល',
                          maxLines: 2,
                          //softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Spacer(),
                Text(
                  'តម្លៃសរុប: $totalPrice${widget._product.currency}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _showContactInfo(userName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DeliveryInfo(userName, _onChangeContact);
      },
    );
  }

  _onChangeContact(String name) async {
    setState(() {
      _isLoading = true;
    });
    await _users.doc(_auth.currentUser.phoneNumber).update({'user_name': name});
    // await _auth.currentUser.updateProfile(displayName: name);
    // await _auth.currentUser.reload();
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildNextButton() {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              height: 54.0,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text('ទិញ',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                onPressed: () {
                  order();
                },
              )),
        ],
      ),
    );
  }

  order() async {
    if (_address.addressName == null) {
      _showMessage('សូមកំណត់ទីតាំងរបស់អ្នកងាយស្រួលក្នុងការដឹកជញ្ជូន', context);
      return;
    }
    if (_auth.currentUser.displayName == null ||
        _auth.currentUser.displayName == '') {
      _showMessage('សូមបញ្ចូលឈ្មោះរបស់អ្នកងាយស្រួលក្នុងការដឹកជញ្ជូន', context);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('lat ${prefs.get('lat')}');
    print('lat ${prefs.get('addressName')}');
    prefs.setDouble('lat', _address.lat);
    prefs.setDouble('lng', _address.lat);
    prefs.setString('addressName', _address.addressName);
    prefs.setString('addressNote', _address.addressNote);
    _address.addressNote = _addressNoteController.text;
    Order order = Order();
    order.productPrice = widget._product.price;
    order.productName = widget._product.name;
    order.unit = widget._product.unit;
    order.currency = widget._product.currency;
    order.productImage = widget._product.image;
    order.currency = widget._product.currency;
    order.productId = widget._product.id;
    order.addressNote = _address.addressNote;
    order.addressName = _address.addressName;
    order.lat = _address.lat;
    order.lng = _address.lng;
    order.status = StatusType('WAITING');
    order.customerName = _auth.currentUser.displayName;
    order.phoneNumber = _auth.currentUser.phoneNumber;
    order.qty = widget._qty.toString();
    order.totalPrice = totalPrice.toString();
    await FirebaseFirestore.instance
        .collection('order')
        .doc()
        .set(order.toJson())
        .then((value) => {
              Navigator.of(context).pushNamed(Constant.THANK_YOU_PAGE)
              // _showMessage("ការបញ្ជាទិញរបស់បានជោគជ័យ\n សូមអរគុណច្រើន!", context)
            })
        .catchError(
            (onError) => {_showMessage("Something when wrong!!!", context)});
    setState(() {
      _isLoading = false;
    });
  }

  _showMessage(String message, BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text('យល់ព្រម'),
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
}
