import 'package:flutter/material.dart';

class ThankYouPage extends StatefulWidget {
  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WillPopScope(
          onWillPop: () => null,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/image/thanks_character.png', width: 300,),
                // Icon(Icons.check_circle_outline, color: Theme.of(context).primaryColor, size: 120),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text('ការបញ្ជាទិញរបស់បានជោគជ័យ\n សូមអរគុណច្រើន!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor)),
                ),
                SizedBox(height: 32),
                Container(
                  width: 250,
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(32.0),
                      ),
                      onPressed: () {
                        // AppManager.instance.onCartChange();
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text('មើលទំនិញផ្សេងទៀត', style: TextStyle(color: Colors.white)),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
