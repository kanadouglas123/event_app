import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static const LatLng _pGooglePle= LatLng(37.4223, -122.0848);
  static const LatLng _pGooglePark= LatLng(37.4223, -122.0848);
  final TextEditingController _mapSearch=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[400],
        title:  Padding(
          padding:const  EdgeInsets.only(bottom: 4,top: 4),
          child: Material(
            color: Colors.white,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child:  Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: _mapSearch,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "enter search place",
                  hintStyle: TextStyle(color: Colors.black)
                ),
              
              ),
            )),
        ),
      ),
      body: GoogleMap(initialCameraPosition:
       const CameraPosition(target: _pGooglePle, zoom: 13),
     markers: {
     const  Marker(
        markerId:MarkerId('_currentLocation'),
        icon: BitmapDescriptor.defaultMarker,
        position: _pGooglePle
 ),
  const Marker(
        markerId:MarkerId('_sourceLocation'),
        icon: BitmapDescriptor.defaultMarker,
        position: _pGooglePark
 )
     },
        ),
    );
  }
}