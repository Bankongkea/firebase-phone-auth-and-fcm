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

Widget getStructuredGridCell(Product product) {
  return Stack(
    children: [
      Container(
        child: Card(
          elevation: 1.5,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.max,
            // verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Image.network(product.image,
                  height: 180, width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Text(product.description,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text('ចំនួននៅក្នុងស្ដុក: '),
                        Text(product.qty)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 16,
        right: 16,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(4.0),
            border:
                Border.all(width: 0.5, color: Colors.black.withOpacity(0.2)),
          ),
          child: Text(
            product.price,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}
Widget home(){
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('product').snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
        // gridDelegate:
        //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data();
          Product product = Product.fromJson(data);
          return getStructuredGridCell(product);
        }).toList(),
      );
    },
  );
}
