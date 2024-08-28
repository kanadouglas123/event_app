import 'dart:convert';
import 'package:event_app/Userprefs/User_prefes.dart';
import 'package:event_app/constants/api_constants.dart';
import 'package:event_app/widget/commentTile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:event_app/map.dart';

class Details extends StatefulWidget {
  final String eventTitle;
  final String location;
  final String date;
  final String time;
  final ImageProvider image;
  final String description;
  final String id;

  const Details({super.key, 
    required this.eventTitle,
    required this.location,
    required this.date,
    required this.time,
    required this.image,
    required this.description,
    required this.id,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isFollowing = true;
  bool isLogging = false;
  bool isfavorite=false;
  // ignore: non_constant_identifier_names
  final TextEditingController _CommentController = TextEditingController();
  // ignore: non_constant_identifier_names
  int user_id = 0;

    // ignore: non_constant_identifier_names
   
  


  @override
  void dispose() {
    _CommentController.dispose();
    super.dispose();
  }
 Future<List<dynamic>> fetchedComment() async {
    final response = await http.get(Uri.parse(API.fetchComment));
 
  
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        return responseBody['data'];
      } else {
        throw Exception('Failed to load comments');
      }
    } else {
      throw Exception('Failed to load comment');
    }
  }
   // ignore: non_constant_identifier_names
   Future<List<dynamic>>? _Comment;

  @override
  void initState() {
    super.initState();
    getUserData();
    _Comment=fetchedComment();

  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(widget.eventTitle),
      ),
      body: SingleChildScrollView(
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
                Positioned(
                      top: 15,
                      right: 30,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        height: 40,
                        width: 40,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isfavorite = !isfavorite;
                            });
                          },
                          icon: isfavorite
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border),
                        ),
                      ),
                    ),
               
                Positioned(
                  right: 20,
                  left: 20,
                  bottom: -63,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    width: 300,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   widget.eventTitle,
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 20,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today),
                                      Text(widget.date),
                                      const SizedBox(width: 20),
                                      Text(widget.time),
                                    ],),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.location_on_rounded),
                                      Text(widget.location),
                                    ],),],
                              ),
                              const SizedBox(width: 40),
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
            const SizedBox(height: 80,),    
        
        
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.white,
                      child:FutureBuilder<List<dynamic>>(
                          future: _Comment,
                          builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Center(child: CircularProgressIndicator(color: Colors.red[900],)));
                          } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                  return const Center(child: Text('no comment found',style: TextStyle(color: Colors.black),));
                          } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final comment = snapshot.data?[index];
                      
                    
                      if(widget.id==comment['event_Id']){
                        return CommentTile(name: comment['user_id'], comment:comment['comment'] );
                      }else{
                        return const  Text('');
                      }
                      
                    },
                  );
                          }
                        }),
                    ),
                  ),
                  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/persn2.jpeg"),
                        radius: 15,
                      ),
                      const SizedBox(width: 15),
                      const Column(
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
                        
                        ],
                      ),
                      const SizedBox(width: 30),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isFollowing = !isFollowing;
                          });
                        },
                        child: isFollowing
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    isFollowing = !isFollowing;
                                  });
                                  Fluttertoast.showToast(msg: 'You unfollowed');
                                },
                                child: const Card(
                                  elevation: 20,
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Following",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    isFollowing = !isFollowing;
                                  });
                                  Fluttertoast.showToast(msg: 'You started following');
              
                              },
                              child: const Card(
                                 elevation: 20,
                                                      color: Colors.red,
                                child:  Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      "Follow",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
                    
                    ],
                  ),
                ),
              ),
            ),
              InkWell(
                 onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Map()));
                          },
                child: const Card(
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
              ),
            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "your ticket is processing");
              },
              child: const Card(
                elevation: 20,
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Buy Ticket Shs200k",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
                ],
              ),
            )     ,
            
          ],
        ),
      ),
     bottomNavigationBar: Flexible(
       child: Row(
         children: [
           Expanded(
             child: Card(
               elevation: 5,
               color: Colors.white,
               child: Padding(
                 padding: const EdgeInsets.only(left: 14, bottom: 5),
                 child: TextField(
                   controller: _CommentController,
                   style: const TextStyle(color: Colors.black),
                   textAlign: TextAlign.left,
                   decoration: const InputDecoration(
                     label: Text(
                       "Comment",
                       style: TextStyle(color: Colors.black, fontSize: 17),
                     ),
                     border: InputBorder.none,
                     hintText: "Comment on the event",
                     hintStyle: TextStyle(color: Colors.black45),
                   ),
                 ),
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(right: 10),
             child: IconButton(
               icon: const Icon(Icons.send, color: Colors.red),
               onPressed: () {
                   
                       if (_CommentController.text.isEmpty) {
                         Fluttertoast.showToast(msg: "Enter a comment please");
                       } else {
                         sendComment();
                       
                     }
                 // Add your send comment functionality here
               },
             ),
           ),
         ],
       ),
     ),
    );
  }

  void getUserData() async {
    var uid = await RememberUser().getUserId() ?? '';
    setState(() {
      user_id = int.parse(uid);
    });
  }
 void sendComment() async {
  String comment = _CommentController.text.trim();
  int eventId = int.parse(widget.id);
  Fluttertoast.showToast(msg: "Submitting your comment");
  try {
    var resSignIn = await http.post(
      Uri.parse(API.comment),
      body: {
        'comment': comment,
        'user_id': user_id.toString(),
        'event_id': eventId.toString(), 
      },
    );

    if (resSignIn.statusCode == 200) {
      Fluttertoast.showToast(msg: "Status Code: ${resSignIn.statusCode}");
      var resSignInBody = jsonDecode(resSignIn.body);

      if (resSignInBody['success'] == true) {
        Fluttertoast.showToast(msg: "Your comment is submitted successfully").then((value) => _CommentController.clear());
      } else {
        Fluttertoast.showToast(msg: "Comment not sent");
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to submit comment: ${resSignIn.statusCode}");
    }
  } catch (e) {
    print(e.toString());
    Fluttertoast.showToast(msg: e.toString());
  }
}
 
}