import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';

editProfileBottomSheet(BuildContext context) {
  var size = MediaQuery.of(context).size;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: size.height * 0.2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            color: Colors.white),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                await Provider.of<ImagePickProvider>(context, listen: false)
                    .getImage(ImageSource.gallery);
              },
              child: Row(
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  const Icon(
                    size: 29,
                    FontAwesomeIcons.image,
                  ),
                  SizedBox(
                    width: size.height * 0.012,
                  ),
                  const Text(
                    'Choose from library',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                await Provider.of<ImagePickProvider>(context, listen: false)
                    .getImage(ImageSource.camera);
              },
              child: Row(
                children: [
                  // SizedBox(
                  //   height: size.height * 0.12,
                  // ),
                  const Icon(size: 29, Icons.camera),
                  SizedBox(
                    width: size.height * 0.012,
                  ),
                  const Text(
                    'Take photo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
