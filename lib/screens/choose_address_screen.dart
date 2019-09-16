import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../configs/common.dart';

class ChooseAddressScreen extends StatefulWidget {
  final double lat;
  final double long;
  ChooseAddressScreen({this.lat, this.long});
  @override
  _ChooseAddressScreenState createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = new Set();
  String _address = '';
  var _lat;
  var _long;
  double _zoom = 16.0;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final lat = widget.lat != null ? widget.lat : 21.0048;
    final long = widget.long != null ? widget.long : 105.8453;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).tr('choose_address'),
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
                  components: [new Component(Component.country, "vn")]);
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
                  target: (_lat != null && _long != null)
                      ? LatLng(_lat, _long)
                      : LatLng(lat, long),
                  zoom: _zoom,
                ),
                markers: _markers,
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: (_lat != null &&
              _long != null &&
              _address.isNotEmpty)
          ? Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.4))
              ]),
              padding: EdgeInsets.all(ScreenUtil.instance.setWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(_address),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        AppLocalizations.of(context)
                            .tr('confirm')
                            .toUpperCase(),
                      ),
                      color: Color.fromRGBO(42, 77, 108, 1),
                      textColor: Colors.white,
                      onPressed: () {
                        Map<String, dynamic> returnedData = {
                          'lat': _lat,
                          'long': _long,
                          'address': _address
                        };
                        Navigator.pop(context, returnedData);
                      },
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      try {
        var address =
            await Geocoder.local.findAddressesFromQuery(p.description);
        GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16.0));
        setState(() {
          print(address[0].toMap());
          _address = address[0].addressLine;
          this._lat = lat;
          this._long = lng;
          _markers.clear();
          _markers.add(
            Marker(
              markerId: MarkerId(placeId),
              position: LatLng(lat, lng),
            ),
          );
        });
      } catch (err) {
        print(err);
      }
    }
  }
}
