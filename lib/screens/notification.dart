import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
   NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> notifications = [
    {'title': 'Notification 1', 'body': 'This is the body of notification 1'},
    {'title': 'Notification 2', 'body': 'This is the body of notification 2'},
    {'title': 'Notification 3', 'body': 'This is the body of notification 3'},
    {'title': 'Notification 4', 'body': 'This is the body of notification 4'},
    {'title': 'Notification 5', 'body': 'This is the body of notification 5'},
    {'title': 'Notification 6', 'body': 'This is the body of notification 6'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              showDialog(
                
                context: context, builder: (BuildContext context){
                return AlertDialog(
                  backgroundColor: Colors.white,
                  content:  Text(notifications[index]['body']!,style:const  TextStyle(color: Colors.black54),),
                  title: Text(notifications[index]['title']!, style: const  TextStyle(color: Colors.black87),),
                  actions: [
                    Center(child: MaterialButton(
                      elevation: 4,
                      color: Colors.white,
                      onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text("Ok",style: TextStyle(color: Colors.black),)))
                  ],
                );

              });
            },
            child: Card(
              color: Colors.white,
              elevation: 3,
              child: ListTile(
                leading:const  CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                title: Text(notifications[index]['title']!,style:const  TextStyle(color: Colors.black),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notifications[index]['body']!, style: const TextStyle(color: Colors.black54),),
                    const SizedBox(height: 4.0),
                    const Text(
                      'a few seconds ago',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ],
                ),
            )),
          );
  }));
  }
}