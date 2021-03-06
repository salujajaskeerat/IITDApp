import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.6),
          highlightColor: Colors.grey.withOpacity(0.4),
          enabled: true,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  4,
                  (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          color: Colors.white,
                        ),
                      ))),
        ));
  }
}
