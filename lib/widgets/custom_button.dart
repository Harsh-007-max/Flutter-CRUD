import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.childWidget,
    required this.onPressedFunc,
    this.padding = 7,
    this.margin = 7,
    this.radius = 7,
  });
  final dynamic childWidget, onPressedFunc;
  final double padding, margin, radius;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.all(padding),
        child: ElevatedButton(
          onPressed: onPressedFunc,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
          ),
          child: childWidget,
        ));
  }
}
