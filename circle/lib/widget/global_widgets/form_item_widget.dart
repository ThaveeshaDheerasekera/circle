import 'package:flutter/material.dart';

import 'package:circle/widget/global_widgets/elevated_button_widget.dart';

class FormItemWidget extends StatelessWidget {
  const FormItemWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final String title;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Text(title),
                    ),
                  ),
                ),
                ElevatedButtonWidget(
                  child: Text('Clear'),
                  width: 50,
                  height: 30,
                  borderRadius: 2,
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }
}
