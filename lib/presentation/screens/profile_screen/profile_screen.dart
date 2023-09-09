import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_light/presentation/screens/edit_profile/edit_profile.dart';
import 'package:social_light/presentation/screens/login_screen/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            );
          },
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: const Text('Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      drawer: const Drawer(child: DrawerWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              SizedBox(
                  height: sizeQuery.height * 0.3,
                  child: Column(children: [
                    Container(
                      width: double.infinity,
                      height: sizeQuery.height * 0.24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/download (3).jpeg',
                            )),
                        color: Colors.teal,
                      ),
                    ),
                  ])),
              Positioned(
                right: sizeQuery.height * 0.05,
                left: sizeQuery.height * 0.05,
                bottom: sizeQuery.height * .01,
                child: CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/download (1).jpeg',
                      width: sizeQuery.height * 0.13,
                      height: sizeQuery.height * 0.13,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ]),
            const Text(
              'Suhail',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: sizeQuery.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('Followers', '30', sizeQuery),
                _buildStatItem('Following', '30', sizeQuery),
              ],
            ),
            SizedBox(
              height: sizeQuery.height * 0.01,
            ),
            Container(
              height: sizeQuery.height * 0.01,
              color: const Color.fromARGB(255, 190, 189, 189),
            ),
            GridView.builder(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 15,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 2, crossAxisSpacing: 2, crossAxisCount: 3),
              itemBuilder: (context, index) {
                return SizedBox(
                    child: Image.asset('assets/images/download (2).jpeg',
                        fit: BoxFit.fill));
              },
            )
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            width: double.infinity,
            height: sizeQuery.height * 0.4,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: sizeQuery.height * 0.07),
                CircleAvatar(
                  backgroundImage:
                      const AssetImage('assets/images/download (1).jpeg'),
                  radius: sizeQuery.height * 0.076,
                ),
                SizedBox(height: sizeQuery.height * 0.03),
                const Text('Suhail',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ));
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: sizeQuery.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Theme',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.toggle_on,
                          size: 38,
                        ))
                  ],
                ),
                SizedBox(height: sizeQuery.height * 0.0001),
                const Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: sizeQuery.height * 0.02),
                const Text(
                  'Share App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: sizeQuery.height * 0.02),
                const Text(
                  'About Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: sizeQuery.height * 0.02),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

Widget _buildStatItem(String title, String value, Size sizeQuery) {
  return Container(
    padding: const EdgeInsets.all(8),
    width: sizeQuery.width * 0.4,
    decoration: BoxDecoration(
      color: Colors.teal,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
