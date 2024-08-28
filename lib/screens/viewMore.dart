import 'dart:convert';

import 'package:event_app/constants/api_constants.dart';
import 'package:event_app/widget/Eventcard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
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

  @override
  void initState() {
    super.initState();
    
     _events = fetchEvents();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text("All events"),
        centerTitle: true,
      ),
      body: SafeArea(child: 
      FutureBuilder<List<dynamic>>(
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
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data?[index];
                return EventCard(
                  eventTitle: event['event_title'],
                  location: event['venue'],
                  date: event['date'],
                  time: event['time'],
                  image:NetworkImage('${API.hostConnect}/${event['image']}'), description: event['description'],
                  id: event['event_id'],
                );
              },
            );
          }
        },
      ),
      
      ),
    );
  }
}