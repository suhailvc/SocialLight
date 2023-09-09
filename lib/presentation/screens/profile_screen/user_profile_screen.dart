import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: const Drawer(child: DrawerWidget()),
      body: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                  // decoration: const BoxDecoration(
                  //   color: Colors.teal,
                  //   borderRadius: BorderRadius.vertical(
                  //     bottom: Radius.circular(20.0),
                  //   ),
                  // ),
                  //  color: Colors.amber,
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
                        //borderRadius:
                        // BorderRadius.vertical(bottom: Radius.circular(60))
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
              Positioned(
                  left: sizeQuery.height * 0.216,
                  bottom: sizeQuery.height * 0.05,
                  child: const Text(
                    'Suhail',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
            ]),
            const Text(
              'Suhail',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: sizeQuery.height * 0.01,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Fllowers',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '30',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Fllowing',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '30',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
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
