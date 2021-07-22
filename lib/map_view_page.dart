import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  LocationData _currentPosition;
  String _address, _dateTime;
  GoogleMapController mapController;
  Marker marker;
  Location location = Location();
  double lat;
  double lng;

  GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(11.5461703, 104.9138566);

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ជ្រើសរើសទីតាំង'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/test.png'), fit: BoxFit.cover),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            color: Colors.blueGrey.withOpacity(.8),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: _initialcameraposition, zoom: 15),
                          mapType: MapType.normal,
                          onMapCreated: _onMapCreated,
                          myLocationEnabled: true,
                          onCameraIdle: () {
                            _getAddress(lat, lng).then((value) => {
                                  setState(() {
                                    _address = " $value";
                                  })
                                });
                          },
                          onCameraMove: (cameraPosition) {
                            setState(() {
                              _address = 'រងចាំ';
                              lat = cameraPosition.target.latitude;
                              lng = cameraPosition.target.longitude;
                            });
                          },
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Icon(
                              FontAwesomeIcons.mapPin,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_address != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Address: $_address",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: Text('រួចរាល់'),
        icon: Icon(FontAwesomeIcons.locationArrow),
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 15),
    ));
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        /*_controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(_currentPosition.latitude, _currentPosition.longitude), zoom: 15),
            ));*/
        // _getAddress(_currentPosition.latitude, _currentPosition.longitude)
        //     .then((value) {
        //   setState(() {
        //     _address = " ${value.first.addressLine}";
        //   });
        // });
      });
    });
  }

  Future<String> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add.first.addressLine;
  }
}
