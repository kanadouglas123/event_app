
import 'package:event_app/screens/details.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final String eventTitle;
  final String location;
  final String date;
  final String time;
  final ImageProvider image;
  final String description;
  final String id;

  EventCard({
    required this.eventTitle,
    required this.location,
    required this.date,
    required this.time,
    required this.image,
    required this.description,
    required this.id,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
              eventTitle: widget.eventTitle,
              location: widget.location,
              date: widget.date,
              time: widget.time,
              image: widget.image,
              description:widget.description,
              id:widget.id
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 40,right: 30),
        child: Card(
           
          elevation: 20,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image(
                      height: 150,
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
                  
                    Positioned(
                      top: 15,
                      left: 30,
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
                              isliked = !isliked;
                            });
                          },
                          icon: isliked
                              ? const Icon(Icons.thumb_up_alt)
                              
                              : const Icon(Icons.thumb_up_alt_outlined),
                        ),
                      ),
                    ),
                    //description
                  
                    Positioned(
                      bottom: -150,
                      child: 
                    Container(
        
                      color: Colors.white,
                      width: 100,
                      height: 50,
                      child: Text(widget.description,style: const TextStyle(color:Colors.white),),
                    )
                    
                    ),
                    ///id
                     Positioned(
                      bottom: -150,
                      child: 
                    Container(
        
                      color: Colors.white,
                      width: 100,
                      height: 50,
                      child: Text(widget.id,style: const TextStyle(color:Colors.white),),
                    )
                    
                    )
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
                 
                  ],
                  
                ),
                
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
