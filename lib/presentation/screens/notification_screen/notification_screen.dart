import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/notification_provider/notification_provider.dart';
import 'package:social_light/application/provider/profile_provider/get_profile_data.dart';
import 'package:social_light/presentation/widgets/shimmer.dart';
import 'package:social_light/presentation/widgets/single_widget_shimmer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //var sizeQuery = MediaQuery.of(context).size;
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
        title: const Text('Notification',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Consumer<NotificationProvider>(
          builder: (context, notificationValue, child) {
        return FutureBuilder(
            future: notificationValue.getNotificationProvider(),
            builder: (context, notificationSnapshot) {
              if (!notificationSnapshot.hasData) {
                return const ShimmerLoading(itemCount: 7, containerHeight: 0);
              }
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 5),
                        itemCount: notificationSnapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Consumer<GetProfileDataProvider>(
                              builder: (context, userDataValue, child) {
                            return FutureBuilder(
                                future: userDataValue.getUserData(
                                    notificationSnapshot
                                        .data![index].currentUserId!),
                                builder: (context, userDataValueSnapshot) {
                                  if (!userDataValueSnapshot.hasData) {
                                    return const SingleWidgetShimmer();
                                  }
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: ListTile(
                                      leading: userDataValueSnapshot
                                                  .data!.imgpath ==
                                              null
                                          ? const CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                  "assets/images/585e4bf3cb11b227491c339a.png"))
                                          : CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                  userDataValueSnapshot
                                                      .data!.imgpath!)),
                                      title: Row(
                                        children: [
                                          Text(
                                            userDataValueSnapshot.data!.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "  ${notificationSnapshot.data![index].status!}"),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }
}
