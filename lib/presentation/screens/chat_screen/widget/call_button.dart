import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

ZegoSendCallInvitationButton actionButton(
    bool isVideo, String otherUserId, String name, Size size) {
  return ZegoSendCallInvitationButton(
    notificationTitle: 'call',
    notificationMessage: 'calling', unclickableBackgroundColor: Colors.black,
    isVideoCall: isVideo,
    resourceID: "zego_data", // For offline call notification
    invitees: [
      ZegoUIKitUser(
        id: otherUserId,
        name: name,
      ),
    ],
    iconSize: size,
    buttonSize: const Size(40, 40),
    clickableTextColor: Colors.blue,
    //onPressed: onCallFinished,
  );
}
