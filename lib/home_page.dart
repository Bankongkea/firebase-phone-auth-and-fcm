import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_phone_auth/component/home_product_list.dart';
import 'package:flutter_firebase_phone_auth/model/product.dart';
import 'package:flutter_firebase_phone_auth/order_page.dart';
import 'package:flutter_firebase_phone_auth/profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static List<Widget> _widgetOptions = <Widget>[
    ProductList(),
    OrderPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    var query = FirebaseFirestore.instance.collection('product');
    query.get();

    return Scaffold(
      appBar: AppBar(
        title: Text('ផ្ទះចំការ'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.shoppingCart),
            label: 'ទំនិញ ',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.idBadge),
            label: 'ការបញ្ជាទិញ',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'ព័ត៍មានរបស់អ្នក',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}