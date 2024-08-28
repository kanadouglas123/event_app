
import 'dart:convert';

import 'package:event_app/constants/api_constants.dart';
import 'package:event_app/screens/tickets_detail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  Future<List<dynamic>> fetchEvents() async {
    final response = await http.get(Uri.parse(API.fetchEvent));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        // SnackBar(
        //   content: Text('${responseBody['data']}'),
        // // ignore: use_build_context_synchronously
        // ).show(context);
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
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
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
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data?[index];
                  return EventCard(
                    eventTitle: event['event_title'],
                    location: event['venue'],
                    date: event['date'],
                    time: event['time'],
                    image:NetworkImage('${API.hostConnect}/${event['image']}'),  ticketCost: event['ticket_cost'], description: event['description'],
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

class EventCard extends StatefulWidget {
  final String eventTitle;
  final String location;
  final String date;
  final String time;
  final ImageProvider image;
   final String description;
  final String ticketCost;

  EventCard({super.key, 
    required this.eventTitle,
    required this.location,
    required this.date,
    required this.time,
    required this.image,
    required this.ticketCost, required this.description
    
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isfavorite = true;
  bool isliked=true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketDetails(eventTitle: widget.eventTitle, location: widget.location, date: widget.date, time: widget.time, image: widget.image, description: widget.description, ticket_cost: widget.ticketCost)));
     
      },
      child: Card(
        elevation: 20,
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image(
                    height: 180,
                    image: widget.image,
                  ),
                  Positioned(
                    bottom: -10,
                    right: 30,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      height: 40,
                      width: 40,
                      child: Center(child: Text(widget.date)),
                    ),
                  ),
               
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.eventTitle,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        widget.location,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 40),
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.red,
                        size: 30,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.time,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),
                 const  SizedBox(height: 35,),

                  Center(
                    child: InkWell(
                      onTap: (){
                        Fluttertoast.showToast(msg: "Your ticket is processing");
                      },
                      child: Card(
                        elevation: 50,
                        color: Colors.red,
                       
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Buy ticket at ${widget.ticketCost}',style: const TextStyle(color:Colors.white,fontSize: 16),),
                        ),
                      ),
                    ),
                  )
               
                ],
                
              ),
              
                
            ],
          ),
        ),
      ),
    );
  }
}
