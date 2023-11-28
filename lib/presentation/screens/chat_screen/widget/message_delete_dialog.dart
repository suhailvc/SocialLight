import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_light/application/provider/message_provider/message_provider.dart';

deleteMessageDialog(BuildContext context, String otherUid, String docId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Do you want to dalete"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () async {
                await Provider.of<MessageProvider>(context, listen: false)
                    .deleteMessageProvider(otherUid, docId);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text("Delete")),
        ],
      );
    },
  );
}
