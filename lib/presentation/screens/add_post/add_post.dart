import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.height * 0.5,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  fit: BoxFit.cover, // Use cover to ensure the image fits well
                  image: AssetImage('assets/images/download (3).jpeg'),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Container(
              width: size.width * 0.7,
              height: size.height * 0.076,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal, // Change border color to teal
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                  border: InputBorder.none,
                  hintText: 'Write a caption...',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.teal, // Change hint text color to teal
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                // Your button click logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Background color
                onPrimary: Colors.white, // Text color
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
