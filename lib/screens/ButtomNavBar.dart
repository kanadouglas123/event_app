
import 'package:event_app/screens/Favorite.dart';
import 'package:event_app/screens/Home.dart';
import 'package:event_app/screens/profile.dart';
import 'package:event_app/widget/Tickets.dart';
import 'package:flutter/material.dart';
 // Ensure you have this import

class NaviBar extends StatefulWidget {
  
  const NaviBar({super.key,});

  @override
  State<NaviBar> createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  int _selectedIndex = 0;
  final List _pages = [
    const Home(),
    const Favorite(),
    const Ticket(),
    const ProfilePage()
  ];

  onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
        currentIndex: _selectedIndex,
        elevation: 10,
        backgroundColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.broken_image_outlined), label: "Ticket"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile")
        ],
      ),
    );
  }
}
