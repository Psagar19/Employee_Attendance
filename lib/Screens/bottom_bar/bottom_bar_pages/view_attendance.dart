import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/Common/dimension.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../Common/colors.dart';

class ViewAttendance extends StatefulWidget {
  const ViewAttendance({super.key});

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  String _month = DateFormat("MMMM").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          width: screenWidth(context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.fill,
                  image: AssetImage("lib/images/Sky.jpg"))
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'My Attendance',
                    style: TextStyle(
                        fontFamily: 'Main',
                        fontSize: 25,
                        color: First,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _month,
                        style: TextStyle(
                            fontFamily: 'Main1',
                            fontSize: 22,
                            color: FirstAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        final month = await showMonthYearPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2050),
                          builder: (context, child) {
                            return Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: FirstAccent,
                                      secondary: FirstAccent,
                                      onSecondary: MYwhite,
                                    ),
                                  textTheme: const TextTheme(
                                    headlineMedium: TextStyle(
                                      fontFamily: "Main",
                                    ),
                                      labelSmall: TextStyle(
                                        fontFamily: "Main",
                                      ),
                                      labelLarge: TextStyle(
                                        fontFamily: "Main",
                                      ),
                                  )
                                ),
                              child: child!,

                            );
                          },
                        );

                        if(month != null){
                          setState(() {
                            _month = DateFormat("MMMM").format(month);
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Pick Month',
                          style: TextStyle(
                              fontFamily: 'Main1',
                              fontSize: 22,
                              color: FirstAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const HeightGap(gap: 0.01),
                Container(
                  height: screenHeight(context) * 0.84,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("User")
                        .doc(MyUser.id)
                        .collection("User Record")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                            itemCount: snap.length,
                            itemBuilder: (context, index){
                              return DateFormat('MMMM').format(snap[index]['date'].toDate()) == _month ? Container(
                                margin: EdgeInsets.only(left: 8.0, right: 8.0,top: 8.0),
                                width: screenWidth(context),
                                height: screenHeight(context) * 0.17,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [newSecond, newFirst]),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Second,
                                    boxShadow: [
                                      BoxShadow(
                                        color: FirstAccent,
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                      )
                                    ]),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 110,
                                      right: 110,
                                      child: Container(
                                        width: screenWidth(context),
                                        height: screenHeight(context) * 0.05,
                                        decoration: BoxDecoration(
                                            color: newFirst,
                                            borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight: Radius.circular(8))),
                                        child: Center(
                                            child: Text(
                                              DateFormat('EEEE dd').format(snap[index]['date'].toDate()),
                                              // snap1[index]['Date'].toDate()
                                              style:  TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18, fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 10,
                                      left: 10.0,
                                      child: SizedBox(
                                        width: screenWidth(context),
                                        height: screenHeight(context) * 0.09,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Mark In",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Main1',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                    Text(
                                                      snap[index]['markIn'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Main',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ],
                                                )),
                                            Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Mark Out",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Main1',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                    Text(
                                                      snap[index]['markOut'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Main',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : SizedBox();
                            }
                        );
                      }else{
                        return SizedBox();
                      }
                    },
                  ),
                ),


              ],
            ),
          ),
        ),
      )
    );
  }
}
