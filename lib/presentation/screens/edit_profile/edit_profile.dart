import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: const Text('Edit Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: sizeQuery.height * 0.03),
              const Text('Profile picture',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: sizeQuery.height * 0.02),
              CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/images/download (1).jpeg'),
                radius: sizeQuery.height * 0.066,
              ),
              SizedBox(height: sizeQuery.height * 0.02),
              const Text('Cover photo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: sizeQuery.height * 0.02),
              Container(
                width: 300,
                height: 120,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/download (3).jpeg'))),
              ),
              SizedBox(height: sizeQuery.height * 0.04),
              SizedBox(
                width: sizeQuery.height * 0.39,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: sizeQuery.height * 0.02),
              SizedBox(
                width: sizeQuery.height * 0.39,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'About',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: sizeQuery.height * 0.02),
              SizedBox(
                width: sizeQuery.height * 0.39,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: sizeQuery.height * 0.02),
              ElevatedButton(onPressed: () {}, child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
