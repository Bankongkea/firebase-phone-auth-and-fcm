import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_phone_auth/component/home_product_list.dart';
import 'package:flutter_firebase_phone_auth/model/product.dart';
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
    ProductList(),
    ProductList(),
  ];
  @override
  Widget build(BuildContext context) {
    var query = FirebaseFirestore.instance.collection('product');
    query.get();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ProductList(),//_widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.productHunt),
            label: 'ទំនិញ ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}