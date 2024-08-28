import 'dart:convert';
import 'package:event_app/Userprefs/User_prefes.dart';
import 'package:event_app/constants/api_constants.dart';
import 'package:event_app/screens/create.dart';
import 'package:event_app/screens/search.dart';
import 'package:event_app/screens/viewMore.dart';
import 'package:event_app/widget/Eventcard.dart';
import 'package:flutter/material.dart';
import 'package:event_app/map.dart';

// import 'package:snack/snack.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
Future<List<dynamic>> fetchEvents() async {
    final response = await http.get(Uri.parse(API.fetchEvent));
 
  
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        return responseBody['data'];
      } else {
        throw Exception('Failed to load events');
      }
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<List<dynamic>>? _events;

  final String _currentAddress = "Locating...";
   

  @override
  void initState() {
    super.initState();
    
     _events = fetchEvents();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                 alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 150.6,
                    decoration: BoxDecoration(
                      color: Colors.red[900],
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 30, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Event",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                              SizedBox(width: 250,),
                              Icon(Icons.notifications,size: 35,)
                            ],
                          ),
                           Padding(
                            padding: const EdgeInsets.only(right: 29),
                            child: InkWell(
                               onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const SearchPage()), // Navigate to the SearchPage
                                    );
                                  },

                              child: Card(
                                color: Colors.white,
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      border: InputBorder.none,
                                      hintText: "Search event",
                                      hintStyle: TextStyle(color: Colors.black87),
                                      prefixIcon: Icon(Icons.search, color: Colors.black87,),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -45,
                    left: 30,
                    right: 30,
                    child: GestureDetector(
                       onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Map()));
                          },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        height: 80,
                        width: 220,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Find through the map",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Text(
                                   _currentAddress,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 50),
                           InkWell(
                             onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Map()));
                          },
                             child: const Image(  
                              height: 50,
                              width: 60,
                              image: AssetImage('assets/location.jpeg')),
                           )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 40),
          Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const Text(
                      "Popular Events",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    InkWell(
                      onTap: (){
                        _more();
                      },child:const Text(
                      "View More",
                      style: TextStyle(color: Colors.red),
                    ),)
                  ],
                ),
              ),
             SizedBox(
                height: 250, 
                child:FutureBuilder<List<dynamic>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Center(child: CircularProgressIndicator(color: Colors.red[900],)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No events found'));
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data?[index];
                return EventCard(
                  eventTitle: event['event_title'],
                  location: event['venue'],
                  date: event['date'],
                  time: event['time'],
                  image:NetworkImage('${API.hostConnect}/${event['image']}'), description: event['description'], id: event['event_id'],
                );
              },
            );
          }
        },
      ),
              ),
             Padding(
                padding:  const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Featured Events",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    InkWell(
                      onTap: (){
                        _more();
                      },
                      child: const Text(
                        "View More",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250, // Set the height you want for the ListView
                child:FutureBuilder<List<dynamic>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: Center(child: CircularProgressIndicator(color: Colors.red[900],)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No events found'));
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data?[index];
                return EventCard(
                  eventTitle: event['event_title'],
                  location: event['venue'],
                  date: event['date'],
                  time: event['time'],
                  image:NetworkImage('${API.hostConnect}/${event['image']}'), description: event['description'],id: event['event_id']
                );
              },
            );
          }
        },
      ),
              ),

              ///upcoming event
                 Padding(
                padding:  const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "UpComing Events",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),

                    InkWell(
                      onTap: (){
                        _more();
                      },child:const Text(
                      "View More",
                      style: TextStyle(color: Colors.red),
                    ),)
                  ],
                ),
              ),
               SizedBox(
                height: 250, // Set the height you want for the ListView
                child:FutureBuilder<List<dynamic>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: Center(child: CircularProgressIndicator(color: Colors.red[900],)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No events found'));
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data?[index];
                RememberUser().saveEvent(event);
                return EventCard(
                  eventTitle: event['event_title'],
                  location: event['venue'],
                  date: event['date'],
                  time: event['time'],
                  image:NetworkImage('${API.hostConnect}/${event['image']}'),
                   description: event['description'],
                   id: event['event_id'],
                );
              },
            );
          }
        },
      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEventPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }


   _more() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Events()));


}}
