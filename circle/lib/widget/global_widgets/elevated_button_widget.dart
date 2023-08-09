import 'package:circle/configs/custom_colors.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  ElevatedButtonWidget({
    Key? key,
    required this.child,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        minimumSize: Size(widget.width, widget.height),
        backgroundColor: widget.backgroundColor ?? CustomColors.olive,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      child: widget.child,
    );
  }
}
