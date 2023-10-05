import 'package:flutter/material.dart';
import 'package:social_light/core/constant.dart';

class ProfileImgWidget extends StatelessWidget {
  const ProfileImgWidget(
      {super.key,
      required this.imagePath,
      required this.sizeQuery,
      required this.imageType});

  final Size sizeQuery;
  final String imagePath;
  final ImageType imageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(75)),
        border: Border.all(
          color: Colors.teal,
          width: 5.0,
        ),
      ),
      child: CircleAvatar(
        radius: 50,
        child: ClipOval(
          child: imageType == ImageType.asset
              ? Image.asset(
                  imagePath,
                  width: sizeQuery.height * 0.13,
                  height: sizeQuery.height * 0.13,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  imagePath,
                  width: sizeQuery.height * 0.13,
                  height: sizeQuery.height * 0.13,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
