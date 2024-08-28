import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TicketDetails extends StatefulWidget {
  final String eventTitle;
  final String location;
  final String date;
  final String time;
  final ImageProvider image;
  final String description;
  final String ticket_cost;

  TicketDetails({
    required this.eventTitle,
    required this.location,
    required this.date,
    required this.time,
    required this.image, required this.description, required this.ticket_cost,
  });

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  bool isFollowing = true;
  bool islogging = false;
  TextEditingController _comment=TextEditingController();

  @override
  void initState() {
   _comment;
    super.initState();
  }
  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
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
                clipBehavior: Clip.none,
                children: [
                  Card(
                    child: Image(
                       height: 200,
                      width: double.infinity,
                     fit: BoxFit.cover,
                      
                      image: widget.image,
                    ),
                  ),

                  // favorite button
                  Positioned(
                    right: 15,
                    top: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite_border,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),

                  // back arrow button
                  Positioned(
                    left: 15,
                    top: 12,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:const  Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // onTop Container
                  Positioned(
                    right: 20,
                    left: 20,
                    bottom: -63,
                    child: Container(
                      decoration:const  BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: 300,
                      height: 120,
                      child: Padding(
                        padding:const  EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.eventTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                           const  SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                       const Icon(Icons.calendar_today),
                                        Text(widget.date),
                                       const  SizedBox(width: 20),
                                        Text(widget.time),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.location_on_rounded),
                                        Text(widget.location),
                                      ],
                                    ),
                                  ],
                                ),
                               const  SizedBox(width: 60),
                                const Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage("assets/person1.jpeg"),
                                      backgroundColor: Colors.yellow,
                                      radius: 25,
                                    ),
                                    Positioned(
                                      right: -25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage("assets/persn2.jpeg"),
                                        backgroundColor: Colors.green,
                                        radius: 25,
                                      ),
                                    ),
                                    Positioned(
                                      right: -55,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 25,
                                        child: Text(
                                          "40",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
             const  SizedBox(height: 80),

              // After stack

            Padding(
               padding:  const EdgeInsets.all(8.0),
               child:  Card(
                elevation: 50,
                color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14,bottom: 5),
                    child: TextField(
                      controller: _comment,
                      style: const TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        label: Text("Comment",style: TextStyle(color: Colors.black,fontSize: 17),),
                        border: InputBorder.none,
                        hintText: "comment on the event",
                        hintStyle: TextStyle(color: Colors.black45)
                      ),
                    ),
                  ),
                ),
             ),
             InkWell(
              onTap: () {
                if(_comment.text.isEmpty){
                  Fluttertoast.showToast(
                    backgroundColor: Colors.red[900],
                    msg: "enter a comment please");
                  
                }else{
                   Fluttertoast.showToast(
                    backgroundColor: Colors.green,
                    msg: "Your comment is submitting");

                }
               
              },
               child: const Card(
                color: Colors.white,
                elevation: 30,
               child: Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Text('Submit comment',style: TextStyle(color: Colors.black),),
               )),
             ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  elevation: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                       const  CircleAvatar(
                          backgroundImage: AssetImage("assets/persn2.jpeg"),
                          radius: 25,
                        ),
                       const  SizedBox(width: 15),
                       const  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kana Douglas",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Organiser",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Card(
                          elevation: 20,
                          color: Colors.red,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isFollowing = !isFollowing;
                              });
                            },
                            child: isFollowing
                                ? const Text(
                                    "Following",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                :const  Text(
                                    "Follow",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Card(
                  elevation: 20,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.description,
                          style:const  TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Read more",
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                const Card(
                    color: Colors.white,
                    elevation: 20,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        width: 400,
                        height: 150,
                        image: AssetImage("assets/location.jpeg"))
                    ),
                   ),
              InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: "your ticket is processing");
                },
                child:  Card(
                  elevation: 20,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Buy Ticket at ${widget.ticket_cost}",
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
