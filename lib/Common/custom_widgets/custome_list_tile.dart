import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimension.dart';

class mylisttile extends StatelessWidget {
  const mylisttile({
    super.key,
    required this.ontap,
    this.icons,
    this.listiconcolor,
    required this.title,
    this.listtextcolor,


  });

  final IconData? icons;
  final String title;
  final Function() ontap;
  final Color? listiconcolor;
  final Color? listtextcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(left: 8.0,right: 8.0),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 8.0, right: 8.0,bottom: 8.0, top: 8.0),
        height: kToolbarHeight,
        width: screenWidth(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: Colors.black
            )
        ),
        child: Row(
          children: [
            Icon(icons, color: listiconcolor,size: 30,),
            Spacer(),
            Text(title, style: TextStyle(fontSize: screenHeight(context) * 0.02, fontFamily: "Main", color: listtextcolor),),
            Spacer(flex: 20,),
            Icon(Icons.keyboard_arrow_right, color: listiconcolor,size: 30,)
          ],
        ),
      ),
    );
  }
}
