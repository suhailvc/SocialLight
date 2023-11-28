import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/add_post.dart/add_post_provider.dart';
import 'package:social_light/application/provider/add_post.dart/select_post_img.dart';
import 'package:social_light/presentation/screens/add_post/widget/add_post_bottom_sheet.dart';
import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:social_light/presentation/widgets/warning.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox(),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: Text(
          'New Post',
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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<SelectPostImgProvider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    addPostBottomSheet(context);
                  },
                  child: Container(
                    width: size.width * 0.7,
                    height: size.height * 0.32,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.teal, width: 2),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: value.returnImagePath != null
                            ? FileImage(File(value.returnImagePath!))
                            : const NetworkImage(
                                    'https://static.thenounproject.com/png/396915-200.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                );
              },
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
                controller: descriptionController,
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
              onPressed: () async {
                if (Provider.of<SelectPostImgProvider>(context, listen: false)
                        .postImgUrl ==
                    null) {
                  warning(context, 'Please select photo');
                  return;
                }
                await Provider.of<AddPostProvider>(context, listen: false)
                    .submitPost(
                        context,
                        descriptionController.text,
                        Provider.of<SelectPostImgProvider>(context,
                                listen: false)
                            .postImgUrl!);
                descriptionController.clear();
                // ignore: use_build_context_synchronously
                await Provider.of<SelectPostImgProvider>(context, listen: false)
                    .postImageClear();
                // ignore: use_build_context_synchronously
                warning(context, "Post added  ");
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavScreen(count: 0),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Background color
                foregroundColor: Colors.white, // Text color
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
