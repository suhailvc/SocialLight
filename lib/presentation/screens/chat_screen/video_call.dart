// import 'package:flutter/material.dart';
// //import 'package:zego_cloud/common/static.dart';
// import 'package:social_light/core/constant.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// // class VideoCall extends StatelessWidget {
// //   final String otherUserId;
// //   final String callId;
// //   final String otherUserName;
// //   const VideoCall(
// //       {required this.otherUserName,
// //       required this.callId,
// //       required this.otherUserId,
// //       super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ZegoUIKitPrebuiltCall(
// //         appID: appId,
// //         appSign: appSign,
// //         callID: callId,
// //         userID: otherUserId,
// //         userName: otherUserName,
// //         plugins: [ZegoUIKitSignalingPlugin()],
// //         config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
// //   }
// // }

// // class VideoCall extends StatefulWidget {
// //   final String otherUserId;
// //   final String callId;
// //   final String otherUserName;
// //   const VideoCall(
// //       {required this.otherUserName,
// //       required this.callId,
// //       required this.otherUserId,
// //       super.key});

// //   @override
// //   State<VideoCall> createState() => _VideoCallState();
// // }

// // class _VideoCallState extends State<VideoCall> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ZegoUIKitPrebuiltCallInvitationService(
// //       appID: appId,
// //       appSign: appSign,
// //       callID: widget.callId,
// //       userID: widget.otherUserId,
// //       userName: widget.otherUserName,
// //       plugins: [ZegoUIKitSignalingPlugin()],
// //     );
// //   }
// // }
// userCall({required String otherUserId, required String otherUserName}) {
//   ZegoUIKitPrebuiltCallInvitationService().init(
//     appID: appId,
//     appSign: appSign,
//     // callID: widget.callId,
//     userID: otherUserId,
//     userName: otherUserName,
//     plugins: [ZegoUIKitSignalingPlugin()],
//   );
// }
