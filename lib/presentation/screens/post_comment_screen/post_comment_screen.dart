import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_light/presentation/screens/post_comment_screen/widget/comment_field.dart';

class PostCommentScreen extends StatelessWidget {
  const PostCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        centerTitle: true,
        title: const Text(
          'Suhail',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: sizeQuery.height * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: sizeQuery.height * 0.02,
                ),
                const Text(
                  'contentt',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: sizeQuery.height * 0.02,
            ),
            Container(
              height: sizeQuery.height * 0.34,
              decoration: const BoxDecoration(),
              child: Image.asset(
                'assets/images/download (2).jpeg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 214, 212, 212),
              height: sizeQuery.height * 0.058,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('10'),
                  SizedBox(width: sizeQuery.width * 0.02),
                  const Icon(FontAwesomeIcons.heart),
                  SizedBox(width: sizeQuery.width * 0.05),
                  const Text('10'),
                  SizedBox(width: sizeQuery.width * 0.02),
                  const Icon(FontAwesomeIcons.comment),
                  SizedBox(width: sizeQuery.width * 0.05),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 14,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/download (1).jpeg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: const Text(
                    'Suhail',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('photo comment',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: const Text('3h'),
                );
              },
            ),
          ],
        ),
      ),
      bottomSheet: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CommentField(),
      ),
    );
  }
}
