// // ignore_for_file: library_private_types_in_public_api, deprecated_member_use

// import 'dart:async';

// import 'package:event_app/screens/Home.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SelectLocation extends StatefulWidget {
//   final double? lat, long;

//   const SelectLocation(
//       {Key? key, required this.lat, required this.long, })
//       : super(key: key);

//   @override
//   _SelectLocationState createState() => _SelectLocationState();
// }

// class _SelectLocationState extends State<SelectLocation> {
//   final Completer<GoogleMapController> _controller = Completer();
//   late final CameraPosition _kGoogle;
//   late LatLng _selectedLatLng;
//   double? lat, long;
//   bool _value = false;
//   int _selectedIndex = -1;
//   bool _showBtn = false;
//   late String _address;
//     final String? address='kampala';
//   bool _isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     _address = address!;
//     // _initMarker();
//     lat = widget.lat;
//     long = widget.long;
//     _kGoogle = CameraPosition(
//       target: LatLng(lat!, long!),
//       zoom: 14.4746,
//     );
//     _selectedLatLng = LatLng(lat!, long!);
//     _updateMapLocation(_selectedLatLng);
//     _setCurrentPage();
//   }

//   _setCurrentPage() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     setState(() {
//       localStorage.setString('currentOrderPage', 'location');
//     });
//   }

//   final Set<Marker> _markers = {};

//   TextEditingController _addressController = TextEditingController();

//   Future<LatLng?> _getLatLngFromAddress(String address) async {
//     List<Location> locations = await locationFromAddress(address);
//     if (locations.isNotEmpty) {
//       return LatLng(locations.first.latitude, locations.first.longitude);
//     } else {
//       return LatLng(37.4219999, -122.0840575);
//     }
//   }

//   Future<void> _updateLocationFromAddress() async {
//     String address = _addressController.text;
//     if (address.isNotEmpty) {
//       LatLng? latLng = await _getLatLngFromAddress(address);
//       if (latLng != null) {
//         _updateMapLocation(latLng);
//         setState(() {
//           _isLoading = true;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Address not found')),
//         );
//       }
//     }
//   }

//   void _updateMapLocation(LatLng latLng) async {
//     _markers.clear();
//     _markers.add(Marker(
//       markerId: const MarkerId("1"),
//       position: latLng,
//       infoWindow: InfoWindow(
//         title: await _getAddressFromLatLng(latLng),
//         snippet: '${latLng.latitude}, ${latLng.longitude}',
//       ),
//       draggable: true,
//       onDragEnd: (newPosition) async {
//         _updateMapLocation(newPosition);
//       },
//     ));
//     CameraPosition cameraPosition = CameraPosition(
//       target: latLng,
//       zoom: 14,
//     );
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//     setState(() {
//       lat = double.parse(latLng.latitude.toStringAsFixed(7));
//       long = double.parse(latLng.longitude.toStringAsFixed(7));

//       _isLoading = false;
//     });
//   }

//   Future<String> _getAddressFromLatLng(LatLng latLng) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
//     if (placemarks.isNotEmpty) {
//       Placemark place = placemarks.first;
//       setState(() {
//         _address = '${place.street}, ${place.locality}, ${place.country}';
//       });

//       return '${place.street}, ${place.locality}, ${place.country}';
//     }
//     return 'Unknown';
//   }

//   Future<Position> _getUserCurrentLocation() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) _handleLocationPermission();

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   @override
//   void dispose() {
//     _controller;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const Home()),
//             (Route<dynamic> route) => false);
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor:Colors.amber,
//         appBar: AppBar(
//           title: const Text('Set new Address'),
//           actions: [
//             Icon(Icons.arrow_back_ios)
          
//           ],
        
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               if (_isLoading)
//                 const Opacity(
//                   opacity: 0.6,
//                   child: ModalBarrier(dismissible: false, color: Colors.amber),
//                 ),
//               if (_isLoading)
//                 const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               Column(
//                 children: [
//                   Container(
                    
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 15,
//                       vertical: 10,
//                     ),
//                     child: TextFormField(
//                       controller: _addressController,
//                       keyboardType: TextInputType.text,
                     
//                       textCapitalization: TextCapitalization.words,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'please enter username';
//                         }
//                         return null;
//                       },
//                       enableSuggestions: true,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Address',
//                         labelText: 'Enter home address',
//                         alignLabelWithHint: true,
//                         prefixIcon: Icon(
//                           Icons.pin_drop_outlined,
//                           color: Colors.red,
//                         ),
                       
//                         suffixIcon: IconButton(
//                           onPressed: _updateLocationFromAddress,
//                           icon: const Icon(
//                             Icons.search,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: GoogleMap(
//                       markers: _markers,
//                       mapType: MapType.normal,
//                       initialCameraPosition: _kGoogle,
//                       onMapCreated: (GoogleMapController controller) {
//                         _controller.complete(controller);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: Container(
//           alignment: Alignment.bottomLeft,
//           margin: const EdgeInsets.only(left: 30),
//           child: FloatingActionButton(
//             onPressed: () async {
//               Position position = await _getUserCurrentLocation();
//               LatLng latLng = LatLng(position.latitude, position.longitude);
//               _updateMapLocation(latLng);
//               _isLoading = true;
//             },
//             child: const Icon(Icons.my_location),
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           elevation: 0,
//           child: Container(
//               color: Colors.red,
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
                     
//                       child: ListTile(
//                         tileColor: Colors.white,
//                         // leading: const Icon(Icons.pin_drop_outlined),
//                         title: CheckboxListTile(
//                           value: _selectedIndex == 1,
//                           onChanged: (value) async {
//                             SharedPreferences localStorage =
//                                 await SharedPreferences.getInstance();

//                             debugPrint(_address);
//                             setState(() {
//                               _showBtn = true;
//                               localStorage.setString('address', _address);

//                               localStorage.setString(
//                                   'latitude', lat.toString());
//                               localStorage.setString(
//                                   'longitude', long.toString());
//                               _value = !_value;
//                             });

//                             setState(() {
//                               _selectedIndex = 1;
//                             });
//                           },
//                           title: Center(
//                             child: Column(
//                               children: [
//                                const Padding(
//                                   padding: EdgeInsets.all(5.0),
//                                   child: Align(
//                                     alignment: Alignment.bottomLeft,
//                                     child: Text(
//                                       "Home location",
                                    
//                                     ),
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         "Lat: $lat",
                                      
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 3,
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         "Lng: $long",
                                       
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     _address,
                                  
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     _showBtn == true
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 5,
//                                   vertical: 5,
//                                 ),
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     elevation: 0,
//                                     backgroundColor: Colors.white,
                                 
//                                     shape: RoundedRectangleBorder(
//                                       side: const BorderSide(
//                                           width: 1, // thickness
                                          
//                                           ),
//                                       // border radius
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                   ),
//                                   onPressed: () {
                                    
//                                   },
//                                   child: Center(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           'Next',
                                         
//                                         ),
//                                         SizedBox(
                                       
//                                         ),
//                                         const Icon(
//                                           Icons.arrow_forward,
//                                           size: 25,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 15,
//                               vertical: 10,
//                             ),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Note: Long press marker on the map to drag it to a new" +
//                                     "location of your choice, then tap on the checkbox to confirm your new location",
                                
//                               ),
//                             ),
//                           ),
//                   ],
//                 ),
//               )),
//         ),
//       ),
//     );
//   }
// }
