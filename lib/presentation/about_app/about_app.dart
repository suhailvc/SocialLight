import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: Text(
          'About App',
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            decorationThickness: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .005),
                        ClipOval(
                          child: Image.asset(
                            'assets/images/app logo.png',
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        SizedBox(height: size.height * .03),
                        const Text(
                          'About Socal Light',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * .03),
                        const Text(
                          'Welcome to Social Light! We are a social media platform that connects people from all around the world. Share your moments, chat with friends, and stay updated with the latest news and posts from your network.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * .03),
                        const Text(
                          'Key Features:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: size.height * .03),
                        const ListTile(
                          leading: Icon(Icons.chat),
                          title: Text('Live Chat',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Instantly chat with your friends and connections.',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const ListTile(
                          leading: Icon(Icons.post_add),
                          title: Text('Add Posts',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Share your thoughts and experiences with posts.',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('Get Notifications',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Stay informed with notifications about new activity.',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const ListTile(
                          leading: Icon(Icons.person_add),
                          title: Text('Create User',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Join Social Light and create your user profile.',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: size.height * .03),
                        const Text(
                          'We value your feedback and continuously strive to improve our app. Your input is essential in shaping the future of Hotspot. Please feel free to reach out to us with any suggestions, questions, or issues you may have.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * .03),
                        const Text(
                          'Contact Us:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: size.height * .03),
                        const ListTile(
                          leading: Icon(Icons.email),
                          title: Text('Email',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('muhammadsuhail825@gmail.com',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('Phone',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('+91 9544556395',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
