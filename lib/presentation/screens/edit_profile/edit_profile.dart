import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/image_picker_provider/image_picker.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/presentation/screens/edit_profile/widget/editProfileBottomSheet.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
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
          child: Consumer<ImagePickProvider>(
              builder: (context, imageValue, child) {
            return FutureBuilder(
                future: Provider.of<GetProfileDataProvider>(context)
                    .getUserData(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const SizedBox();
                  }

                  Provider.of<GetProfileDataProvider>(context, listen: false)
                      .nameController
                      .text = userSnapshot.data!.name!;
                  Provider.of<GetProfileDataProvider>(context, listen: false)
                      .userNameController
                      .text = userSnapshot.data!.username!;
                  return Column(
                    children: [
                      SizedBox(height: sizeQuery.height * 0.18),
                      const Text('Profile picture',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: sizeQuery.height * 0.02),
                      GestureDetector(
                          onTap: () async {
                            await editProfileBottomSheet(context);
                          },
                          child: imageValue.imageUrl == null
                              ? Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.teal, width: 3),
                                    borderRadius: BorderRadius.circular(
                                        sizeQuery.height * 0.1),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        userSnapshot.data!.imgpath!),
                                    radius: sizeQuery.height * 0.09,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.teal, width: 3),
                                    borderRadius: BorderRadius.circular(
                                        sizeQuery.height * 0.09),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(imageValue.imageUrl!),
                                    radius: sizeQuery.height * 0.09,
                                  ),
                                )),
                      SizedBox(height: sizeQuery.height * 0.02),
                      SizedBox(
                        width: sizeQuery.height * 0.39,
                        child: TextFormField(
                          controller: Provider.of<GetProfileDataProvider>(
                                  context,
                                  listen: false)
                              .nameController,
                          decoration: InputDecoration(
                              hintText: 'Name',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(height: sizeQuery.height * 0.02),
                      SizedBox(
                        width: sizeQuery.height * 0.39,
                        child: TextFormField(
                          controller: Provider.of<GetProfileDataProvider>(
                                  context,
                                  listen: false)
                              .userNameController,
                          decoration: InputDecoration(
                              hintText: 'User Name',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(height: sizeQuery.height * 0.02),
                      SizedBox(height: sizeQuery.height * 0.02),
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.teal)),
                          onPressed: () async {
                            await Provider.of<GetProfileDataProvider>(context,
                                    listen: false)
                                .editUserDataProvider(
                                    context: context,
                                    newNameController:
                                        Provider.of<GetProfileDataProvider>(
                                                context,
                                                listen: false)
                                            .nameController
                                            .text,
                                    newImagepath: imageValue.imageUrl,
                                    newUserNameController:
                                        Provider.of<GetProfileDataProvider>(
                                                context,
                                                listen: false)
                                            .userNameController
                                            .text);
                            // ignore: use_build_context_synchronously
                            Provider.of<ImagePickProvider>(context,
                                    listen: false)
                                .clearImage();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Submit',
                          ))
                    ],
                  );
                });
          }),
        ),
      ),
    );
  }
}
