import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/search_provider/search_provider.dart';
import 'package:social_light/presentation/screens/profile_screen/user_profile_screen.dart';
import 'package:social_light/presentation/widgets/follow_button.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<UserSearchProvider>(context).searchController;
    var sizeQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: Text(
          'Search',
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
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: sizeQuery.height * 0.03,
          ),
          SizedBox(
            width: sizeQuery.height * 0.47,
            child: TextFormField(
              controller: controller,
              onChanged: (value) {
                Provider.of<UserSearchProvider>(context, listen: false)
                    .searchlist(value);
              },
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    Provider.of<UserSearchProvider>(context, listen: false)
                        .searchlist('');
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: sizeQuery.height * 0.01),
          Expanded(child: Consumer<UserSearchProvider>(
            builder: (context, value, child) {
              return FutureBuilder(
                  future: value.getAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ShimmerLoading(
                          itemCount: 7, containerHeight: 0);
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error fetching data'));
                    } else {
                      final userList = controller.text.isEmpty
                          ? value.allusers
                          : value.searchedlist;

                      if (userList.isEmpty) {
                        return const Center(child: Text('No data available'));
                      }
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        //shrinkWrap: true,
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          final user = userList[index];
                          return InkWell(
                            // highlightColor: Colors.red,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtherUserProfileScreen(
                                              userId: user.uid!)));
                            },
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: const AssetImage(
                                    'assets/images/download (1).jpeg',
                                  ),
                                  radius: 23,
                                  child: ClipOval(
                                    child: user.imgpath != null
                                        ? Image.network(
                                            user.imgpath.toString(),
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
                                title: Text(
                                  user.name!,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                    decorationThickness: 2.0,
                                  ),
                                ),
                                subtitle: Text(
                                  user.username!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: FollowButton(
                                    token: userList[index].pushToken ?? '',
                                    otherUserId:
                                        userList[index].uid.toString())),
                          );
                        },
                      );
                    }
                  });
            },
          ))
        ],
      )),
    );
  }
}
