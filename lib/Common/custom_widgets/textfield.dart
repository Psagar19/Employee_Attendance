import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimension.dart';

class Mytextfield extends StatelessWidget {
  const Mytextfield({
    super.key,
    required this.controller,
    required this.Keyboardtype,
    this.Obscure = false,
    required this.hint,
    this.myicon,
    this.suffixbutton, this.OnTap,
    this.ReadOnly = false,
    this.maxchar,
    this.maxLines,
  });

  final TextEditingController controller;
  final TextInputType Keyboardtype;
  final bool Obscure, ReadOnly;
  final int? maxchar, maxLines;
  final String hint;
  final IconData? myicon;
  final IconButton? suffixbutton;
  final Function()? OnTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: OnTap,
        readOnly: ReadOnly,
        controller: controller,
        keyboardType: Keyboardtype,
        maxLines: maxLines,
        obscureText: Obscure,
        maxLength: maxchar,
        cursorColor: FirstAccent,
        style: TextStyle(fontSize: 16,fontFamily: "Main1", color: FirstAccent),
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(myicon, color: FirstAccent),
            suffixIcon: suffixbutton,
            enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5
                )
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
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
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      height: screenHeight(context) * 0.07,
      padding: const EdgeInsets.only(
          left: 8.0, right: 8.0, top: 8.0, bottom: 10.0),
      width: screenWidth(context),
      decoration: BoxDecoration(
          color: Second,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black)),
      child:
      Row(
        children: [
          Icon(myicon, size: 25,color: FirstAccent,),
          Spacer(),
          Text(text, style: TextStyle(fontSize: 16,fontFamily: "Main1", color: FirstAccent),),
          Spacer(flex: 20,),
        ],
      ),
    );
  }
}