import 'package:event_app/Auth/login.dart';
import 'package:event_app/Userprefs/User_prefes.dart';
import 'package:event_app/constants/colors.dart';
import 'package:event_app/screens/ButtomNavBar.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: "AIzaSyA8ywhHmQCKBfXOf70I3J8i1Kz2-9hewHw", 
  //     appId:"1:575812145051:android:526d58ccf2ea342da31b3e",
  //     messagingSenderId: "575812145051",
  //     projectId: "event-e5efa",
  //   ),
  // );
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     theme: LightMode,
     darkTheme: DarkMode,
      home: FutureBuilder<bool>(
        future: RememberUser.isUserLoggedIn() ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == true) {
              
              return const  NaviBar();
            } else {
              return const  Login();
            }
          }
        },
      ),
    );
  }
}