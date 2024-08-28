import 'dart:convert';
import 'package:event_app/constants/api_constants.dart';
import 'package:event_app/widget/Eventcard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _events = [];
  dynamic searchedEvent;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final response = await http.get(Uri.parse(API.fetchEvent));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body); 
      if (responseBody['success'] == true) {
        setState(() {
          _events = responseBody['data'];
        });
      } else {
        throw Exception('Failed to load events');
      }
    } else {
      throw Exception('Failed to load events');
    }
  }

  void _searchEvent(String query) {
  final matchedEvent = _events.firstWhere(
    (event) => event['event_title']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()),
    orElse: () => null,
  );
  setState(() {
    searchedEvent = matchedEvent;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search Events'),
        backgroundColor: Colors.red[900],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 20,
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Enter event name',
                      hintStyle: TextStyle(color: Colors.black87),
                      prefixIcon: Icon(Icons.search, color: Colors.black87),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _searchEvent(value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                searchedEvent != null
  ? EventCard(
      eventTitle: searchedEvent['event_title'],
      location: searchedEvent['venue'],
      date: searchedEvent['date'],
      time: searchedEvent['time'],
      image: NetworkImage('${API.hostConnect}/${searchedEvent['image']}'),
      description: searchedEvent['description'],
      id: searchedEvent['event_id'],
    )
  : const Text('No matching events found?',style: TextStyle(color: Colors.black,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}