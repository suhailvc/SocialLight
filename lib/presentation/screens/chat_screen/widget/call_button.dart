import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

ZegoSendCallInvitationButton actionButton(
    bool isVideo, String otherUserId, String name) {
  return ZegoSendCallInvitationButton(
    isVideoCall: isVideo,
    resourceID: "zego_data", // For offline call notification
    invitees: [
      ZegoUIKitUser(
        id: otherUserId,
        name: name,
      ),
    ],
    // iconSize: Size(20),
    // buttonSize: ZegoScreenUtil.defaultSize,
    //onPressed: onCallFinished,
  );
}
