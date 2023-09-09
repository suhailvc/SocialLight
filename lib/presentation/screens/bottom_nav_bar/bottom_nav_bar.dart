import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_light/presentation/screens/add_post/add_post.dart';
import 'package:social_light/presentation/screens/home_screen/home_screen.dart';
import 'package:social_light/presentation/screens/message_screen/message.dart';
import 'package:social_light/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_light/presentation/screens/search_screen/search_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AddPost(),
    const MessageScreen(),
    const ProfileScreen(),
  ];
  var myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[myIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          unselectedItemColor: const Color.fromARGB(255, 73, 71, 71),
          selectedItemColor: Colors.black,
          backgroundColor: Colors.amber,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'search',
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.circlePlus), label: 'Add Post'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.message), label: 'Message'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.circleUser), label: 'Profile'),
          ]),
    );
  }
}
