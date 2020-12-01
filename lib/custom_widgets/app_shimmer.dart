import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swift_flutter/resources/resources.dart';

class AppShimmer extends StatelessWidget{
  final Widget child;
  AppShimmer({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Resources.APP_PRIMARY_COLOR,
      child: child
    );
  }
}