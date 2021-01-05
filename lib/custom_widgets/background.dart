import 'package:flutter/cupertino.dart';
import 'package:swift_flutter/resources/resources.dart';

class Background extends StatefulWidget {
  final Widget child;

  Background({@required this.child});

  @override
  _Background createState() => _Background();
}

class _Background extends State<Background> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(Resources.BG_IMAGE),
          //     fit: BoxFit.cover,
          //   ),
          // ),
        ),
        widget.child??SizedBox()
      ],
    );
  }
}
