import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
          'Privacy Policy',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * .01),
              const Text(
                'Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: size.height * .03),
              const Text(
                'This Privacy Policy governs the manner in which our Hotspot app collects, uses, maintains, and discloses information collected from users of the Hotspot app.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: size.height * .03),
              const Text(
                'Personal Identification +Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: size.height * .03),
              const Text(
                'We may collect personal identification information from Users in a variety of ways, including, but not limited to, when Users interact with the App, register on the App, and in connection with other activities, services, features, or resources we make available on our App. Users may be asked for, as appropriate, name, email address. Users may, however, visit our App anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: size.height * .03),
              const Text(
                'Non-Personal Identification Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: size.height * .03),
              const Text(
                'We may collect non-personal identification information about Users whenever they interact with our App. Non-personal identification information may include the browser name, the type of computer, and technical information about Users\' means of connection to our App, such as the operating system and the Internet service providers utilized and other similar information.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: size.height * .03),
              const Text(
                'How We Use Collected Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: size.height * .03),
              const Text(
                'We may collect and use Users\' personal information for the following purposes:',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: size.height * .03),
              const Text('- To personalize user experience',
                  style: TextStyle(fontSize: 15)),
              const Text('- To improve our App',
                  style: TextStyle(fontSize: 15)),
              SizedBox(height: size.height * .03),
            ],
          ),
        ),
      ),
    );
  }
}
