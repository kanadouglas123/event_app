import 'package:event_app/widget/Eventcard.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final List FavList=[
     //EventCard( eventTitle: "HipHop Night", location: "Mbarara",date: "25\nDec",time: "4:00pm", image: const AssetImage("assets/event2.jpg"), description: '', ),
     //EventCard( eventTitle: "Dancehall Night", location: "mukono",date: "01/Sept", time: "3:00pm", image: const AssetImage("assets/event6.jpeg"), description: '',),
     //EventCard(eventTitle: "Bear Night", location: "Shaule", date: "21\nJune", time: "2:00pm", image: const AssetImage("assets/event8.jpeg"), description: '',  ),
   // EventCard(eventTitle: "HipHop Night", location: "Lugazi", date: "20\nDec", time: "4:00pm", image: const AssetImage("assets/event1.jpg"), description: '',  ),
    //EventCard(eventTitle: "Campusers Night", location: "Jinja", date: "21\nMay", time: "2:00pm", image: const AssetImage("assets/event4.jpeg"), description: '',  ),
   EventCard(eventTitle: "HipHop Night", location: "Kampala", date: "21\nNov", time: "8:00pm", image: const AssetImage("assets/event5.jpeg"), description: '',id: '',  ),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      title:  const Text("Your Intersests"),
        backgroundColor: Colors.red[900],
      ),    
      backgroundColor: Colors.white,
       body:ListView.builder(
              itemCount:FavList.length ,
              itemBuilder: (context, index) {
                if(FavList.isEmpty){
                  return const Center(child: Text("no favourites yet",style: TextStyle(color:Colors.black),),);
                }else{
                  return FavList[index];
                }
                
              
            },)
    );
  }
}