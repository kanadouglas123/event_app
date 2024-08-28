import 'package:event_app/Auth/login.dart';
import 'package:event_app/Userprefs/User_prefes.dart';
import 'package:event_app/screens/create.dart';
import 'package:event_app/screens/chat.dart';
import 'package:event_app/screens/notification.dart';
import 'package:event_app/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? _profileImage;

  
@override
  void initState() {
    super.initState();
    getUserData();
  }

  var id='0';
  var username= "";
  var email='';



void getUserData() async{
  String uname = await RememberUser().getUserName() ?? '';
  String uid = await RememberUser().getUserId() ?? '';
  String uemail=await RememberUser().getUserEmail() ?? '';
  setState(() {
    id = uid;
     username = uname;
     email=uemail;
  });
     
}
  
  Future<void> pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.red[900],
                       
            
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/Elogo.png",
                          width: 100,
                          height: 80,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      left: 30,
                      right: 30,
                      child: Card(
                       
                        color: Colors.white,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: pickProfileImage,
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : const AssetImage("assets/event1.jpg") as ImageProvider,
                                ),
                              ),
                              const SizedBox(width: 20),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    username,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                   Text(
                                    email,
                                    style: const TextStyle(color: Colors.black),
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
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    ProfileList(icon: Icons.create_new_folder, text: 'create event', pressed:(){
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateEventPage()),
            );
                    }
                    
                    ),
                    ProfileList(
                      icon: Icons.notifications,
                      text: 'Notifications',
                      pressed: () {
                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
                      },
                    ),
                    ProfileList(
                      icon: Icons.payment,
                      text: 'Payment Method',
                      pressed: () {
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Payment()),
            );
                      },
                    ),
                    ProfileList(
                      icon: Icons.chat,
                      text: 'Chat',
                      pressed: () {
                         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Help()),
            );
                      },
                    ),
                    ProfileList(icon: Icons.logout_outlined, text: 'LogOut', pressed: (){
          
                       showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: const Text("Are you sure you want to Logout?",style: TextStyle(color: Colors.black,fontSize: 15),),
                actions: [
                  InkWell(
                  onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                  },
                  child:const Card(
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30,left: 30,bottom: 4,top: 4),
                      child: Text("ok",style: TextStyle(fontSize: 17, color: Colors.black),),
                    ) )),
                    const SizedBox(width: 40,),
                 
                InkWell(
                  onTap: (){
                     Navigator.pop(context);
                  },
                  child:const Card(
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                    padding: EdgeInsets.only(right: 8,left: 8,top: 4,bottom: 4),
                    child: Text("cancel",style: TextStyle(fontSize: 17, color: Colors.black),),
                  ) ) ),
                
                  
          
                ],
              );
            },
          );            
                    })
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class ProfileList extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback pressed;

  ProfileList({super.key, required this.icon, required this.text, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.red[900], size: 30),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward, color: Colors.black54),
      onTap: pressed,
    );
  }
}
