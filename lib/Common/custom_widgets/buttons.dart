import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimension.dart';

class MyElevatedbutton extends StatelessWidget {
  const MyElevatedbutton({
    super.key,
    required this.onpress,
    required this.text,
  });
  final Function() onpress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        alignment: Alignment.center,
        height: kToolbarHeight,
        width: screenWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [newFirst, newSecond],begin: Alignment.center,end: Alignment.centerRight,tileMode: TileMode.mirror,transform: const GradientRotation(50)),
        ),
        child: Text(text, style: TextStyle(color: myWhite,fontSize: screenHeight(context) * 0.03, fontFamily: "Main"),),
      ),
    );
  }
}