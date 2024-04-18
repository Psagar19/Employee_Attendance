import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimension.dart';

class Mytextfield extends StatelessWidget {
  const Mytextfield({
    super.key,
    required this.controller,
    required this.keyboardtype,
    this.obscure = false,
    required this.hint,
    this.myicon,
    this.suffixbutton, this.onTap,
    this.readOnly = false,
    this.maxchar,
    this.maxLines,
  });

  final TextEditingController controller;
  final TextInputType keyboardtype;
  final bool obscure, readOnly;
  final int? maxchar, maxLines;
  final String hint;
  final IconData? myicon;
  final IconButton? suffixbutton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        keyboardType: keyboardtype,
        maxLines: maxLines,
        obscureText: obscure,
        maxLength: maxchar,
        cursorColor: firstAccent,
        style: TextStyle(fontSize: 16,fontFamily: "Main1", color: firstAccent),
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(myicon, color: firstAccent),
            suffixIcon: suffixbutton,
            enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.5
                )
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.5
              )
            )
        ));
  }
}


class MyDatashow extends StatelessWidget {
  const MyDatashow({
    super.key,
    required this.myicon,
    required this.text,


  });
  final String text;
  final IconData myicon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      height: screenHeight(context) * 0.07,
      padding: const EdgeInsets.only(
          left: 8.0, right: 8.0, top: 8.0, bottom: 10.0),
      width: screenWidth(context),
      decoration: BoxDecoration(
          color: second,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black)),
      child:
      Row(
        children: [
          Icon(myicon, size: 25,color: firstAccent,),
          const Spacer(),
          Text(text, style: TextStyle(fontSize: 16,fontFamily: "Main1", color: firstAccent),),
          const Spacer(flex: 20,),
        ],
      ),
    );
  }
}