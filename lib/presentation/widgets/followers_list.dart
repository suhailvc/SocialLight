import 'package:flutter/material.dart';
import 'package:social_light/application/provider/follow_provider/follow_provider.dart';
import 'package:social_light/domain/user_model/user_model.dart';
import 'package:social_light/presentation/screens/profile_screen/user_profile_screen.dart';

class FollowersList extends StatelessWidget {
  final String name;
  final List<String>? followers;
  const FollowersList({required this.name, this.followers, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 226, 231, 231),
          title: Text(name,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: followers?.length,
          itemBuilder: (context, index) {
            String? userId = followers?[index];
            return FutureBuilder<UserDetails?>(
                future: FollowProvider().getFollowersProvider(userId),
                builder: (context, followSnapshot) {
                  if (followSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const SizedBox(
                        width: 5, child: CircularProgressIndicator());
                  }
                  if (!followSnapshot.hasData) {
                    return const Center(
                      child: Text("no data"),
                    );
                  }
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OtherUserProfileScreen(userId: userId!),
                            )),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: const AssetImage(
                              'assets/images/download (1).jpeg',
                            ),
                            radius: 23,
                            child: ClipOval(
                              child: followSnapshot.data!.imgpath != null
                                  ? Image.network(
                                      followSnapshot.data!.imgpath!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/585e4bf3cb11b227491c339a.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text(followSnapshot.data!.name ?? ''),
                          subtitle: Text(followSnapshot.data!.username ?? ''),
                        ),
                      )
                    ],
                  );
                });
          },
        ));
  }
}
