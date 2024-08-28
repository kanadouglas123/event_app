import 'package:flutter/material.dart';

class CommentTile extends StatefulWidget {
  final String name;
  final String comment;

  const CommentTile({super.key, required this.name, required this.comment,});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 15,
                child: Icon(Icons.person,color: Colors.black,),
              ),
              title: Text(widget.name,style: const TextStyle(color: Colors.black),),
              subtitle: Text(widget.comment, style: const TextStyle(color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  TextButton(onPressed: (){} ,child: const Text('Like', style: TextStyle(fontSize: 16),)),  const SizedBox(width: 50,),
                  TextButton(onPressed: (){} ,child: const Text('Reply ', style: TextStyle(fontSize: 16),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}