import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_light/domain/user_model/user_model.dart';

Future<UserDetails?> followersList(String? userId) async {
  try {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      return UserDetails.fromJson(userData);
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}
