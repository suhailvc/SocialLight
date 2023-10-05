import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SingleWidgetShimmer extends StatelessWidget {
  const SingleWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 25.0,
              ),
              title: Container(
                width: double.infinity,
                height: 16.0,
                color: Colors.grey[300],
              ),
              subtitle: Container(
                width: double.infinity,
                height: 16.0,
                color: Colors.grey[300],
              ),
            ),
            Container(
              color: Colors.grey[300],
              width: 380,
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
