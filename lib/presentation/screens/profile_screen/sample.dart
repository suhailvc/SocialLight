// Stack(children: [
//                       SizedBox(
//                           height: sizeQuery.height * 0.3,
//                           child: Column(children: [
//                             Container(
//                               width: double.infinity,
//                               height: sizeQuery.height * 0.24,
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: AssetImage(
//                                       'assets/images/download (3).jpeg',
//                                     )),
//                                 color: Colors.teal,
//                               ),
//                             ),
//                           ])),
//                       Positioned(
//                           right: sizeQuery.height * 0.05,
//                           left: sizeQuery.height * 0.05,
//                           bottom: sizeQuery.height * .01,
//                           child: userSnapshot.data!.imgpath != null
//                               ? ProfileImgWidget(
//                                   imageType: ImageType.network,
//                                   imagePath: userSnapshot.data!.imgpath!,
//                                   sizeQuery: sizeQuery)
//                               : ProfileImgWidget(
//                                   imageType: ImageType.asset,
//                                   imagePath:
//                                       'assets/images/585e4bf3cb11b227491c339a.png',
//                                   sizeQuery: sizeQuery)),
//                     ]),