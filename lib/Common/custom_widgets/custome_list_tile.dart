import 'package:flutter/material.dart';

import '../dimension.dart';

class Mylisttile extends StatelessWidget {
  const Mylisttile({
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
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left: 8.0, right: 8.0,bottom: 8.0, top: 8.0),
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
            const Spacer(),
            Text(title, style: TextStyle(fontSize: screenHeight(context) * 0.02, fontFamily: "Main", color: listtextcolor),),
            const Spacer(flex: 20,),
            Icon(Icons.keyboard_arrow_right, color: listiconcolor,size: 30,)
          ],
        ),
      ),
    );
  }
}
