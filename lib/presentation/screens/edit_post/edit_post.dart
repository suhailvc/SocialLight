import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:social_light/application/provider/add_post.dart/get_post_provider.dart';
import 'package:social_light/application/provider/add_post.dart/select_post_img.dart';
import 'package:social_light/presentation/screens/add_post/widget/add_post_bottom_sheet.dart';
import 'package:social_light/presentation/screens/bottom_nav_bar/bottom_nav_bar.dart';

import 'package:social_light/presentation/widgets/warning.dart';

class EditPostScreen extends StatelessWidget {
  final String imgUrl;
  final String postUserId;
  final String postId;
  final String? caption;
  TextEditingController descriptionController;
  EditPostScreen({
    required this.imgUrl,
    required this.postUserId,
    required this.postId,
    this.caption,
  }) : descriptionController = TextEditingController(text: caption ?? '');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 226, 231, 231),
          title: Text(
            'Edit Post',
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
        body: //Consumer<GetPostProvider>(builder: (context, value, child) {
            // return
            // FutureBuilder(
            //     future: Provider.of<GetPostProvider>(context)
            //         .getSinglePostProvider(postId, postUserId),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) {
            //         return const CircularProgressIndicator();
            //       }
            //       descriptionController.text = snapshot.data!.caption!;
            // return
            SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<SelectPostImgProvider>(
                builder: (context, imgValue, child) {
                  return GestureDetector(
                    onTap: () {
                      addPostBottomSheet(context);
                    },
                    child: Container(
                      width: size.width * 0.7,
                      height: size.height * 0.32,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.teal, width: 2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imgValue.returnImagePath != null
                              ? FileImage(File(imgValue.returnImagePath!))
                              : NetworkImage(imgUrl) as ImageProvider,
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
                  String? imgPath;

                  Provider.of<SelectPostImgProvider>(context, listen: false)
                              .returnImagePath ==
                          null
                      ? imgPath = imgUrl
                      : imgPath = Provider.of<SelectPostImgProvider>(context,
                              listen: false)
                          .returnImagePath!;
                  print("................$imgPath");

                  await Provider.of<GetPostProvider>(context, listen: false)
                      .editPostProvider(
                          caption: descriptionController.text,
                          postId: postId,
                          newUrl: Provider.of<SelectPostImgProvider>(context,
                                  listen: false)
                              .postImgUrl);
                  descriptionController.clear();
                  // ignore: use_build_context_synchronously
                  // await Provider.of<SelectPostImgProvider>(context, listen: false)
                  //     .postImageClear();
                  // ignore: use_build_context_synchronously
                  warning(context, "Post edited  ");
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
        )
        // })
        // }),
        );
  }
}
