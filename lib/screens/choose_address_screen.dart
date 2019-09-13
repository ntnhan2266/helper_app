import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';

import '../configs/common.dart';
import '../configs/api.dart';

class ChooseAddressScreen extends StatefulWidget {
  @override
  _ChooseAddressScreenState createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);

  GoogleMapController _controller;
  final Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(21.0048, 105.8453);
  String _address = '';
  var _lat = null;
  var _long = null;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final lat = args != null ? args['lat'] : 21.0048;
    final long = args != null ? args['long'] : 105.8453;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _address.isNotEmpty ? _address : AppLocalizations.of(context).tr('choose_address'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              // show input autocomplete with selected mode
              // then get the Prediction selected
              Prediction p = await PlacesAutocomplete.show(
                context: context,
                apiKey: GOOGLE_API_KEY,
                mode: Mode.fullscreen, // Mode.fullscreen
                language: "vn",
                components: [new Component(Component.country, "vn")]
              );
              displayPrediction(p);
            },
          )
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: (_lat != null && _long != null) ? LatLng(_lat, _long) : LatLng(lat, long),
                  zoom: 16.0,
                ),
                markers: this._listMakers(),
                mapType: MapType.normal,
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      setState(() {
        _address = address[0].addressLine; 
        this._lat = lat;
        this._long = lng;
        _controller.moveCamera(CameraUpdate.newLatLng(LatLng(_lat, _long)));

      });
      print(lat);
      print(lng);
    }
  }

  Set<Marker> _listMakers() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_mainLocation.toString()),
        position: _mainLocation,
        infoWindow: InfoWindow(
          title: 'Historical City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    return _markers;
  }
}
