import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/Common/colors.dart';
import 'package:employee_attendance/Common/dimension.dart';
import 'package:employee_attendance/Screens/bottom_bar/bottom_bar_pages/menus_pages/profile_edit.dart';
import 'package:employee_attendance/Screens/bottom_bar/bottom_bar_pages/view_attendance.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../Common/custom_widgets/custome_list_tile.dart';
import 'menus_pages/userdetails.dart';

class MenusPages extends StatefulWidget {
  const MenusPages({super.key});

  @override
  State<MenusPages> createState() => _MenusPagesState();
}

class _MenusPagesState extends State<MenusPages> {
  final logout = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.fill,
                  image: AssetImage("lib/images/Sky.jpg"))),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: screenWidth(context),
                  height: screenHeight(context) * 0.25,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [newSecond, newFirst]),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 2)
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 20.0),
                  width: 135,
                  height: 135,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: ClipOval(
                    child: MyUser.profilePicLink == " "
                        ? Icon(
                            Icons.person,
                            size: 100,
                          )
                        : Image.network(
                            fit: BoxFit.fill, MyUser.profilePicLink),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20.0,
                  right: 10.0,
                  child: Container(
                    width: screenWidth(context),
                    height: screenHeight(context) * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Id: " + MyUser.employeeId,
                          style: TextStyle(
                              fontSize: screenHeight(context) * 0.024,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Email Id: " + MyUser.emailAddress,
                          style: TextStyle(
                              fontSize: screenHeight(context) * 0.022,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(),));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0),
                      width: screenWidth(context) * 0.2,
                      height: screenHeight(context) * 0.05,
                      child: Icon(Icons.arrow_drop_down, color: Colors.black, size: 30,),
                    ),
                  ),
                )
              ]),
              mylisttile(
                title: "Profile Edit",
                listiconcolor: FirstAccent,
                listtextcolor: FirstAccent,
                icons: Icons.person,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            KeyboardVisibilityProvider(child: ProfileScreen()),
                      ));
                },
              ),
              mylisttile(
                icons: Icons.playlist_add_check_circle,
                listiconcolor: FirstAccent,
                listtextcolor: FirstAccent,
                title: "View Attendance",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAttendance()));
                },
              ),
              mylisttile(
                icons: Icons.calendar_month,
                listiconcolor: Colors.red.shade800,
                listtextcolor: Colors.red.shade800,
                title: "Holiday List",
                ontap: () {},
              ),
              mylisttile(
                icons: Icons.pending_actions,
                listiconcolor: Colors.red.shade800,
                listtextcolor: Colors.red.shade800,
                title: "Leave Request",
                ontap: () {},
              ),
              mylisttile(
                icons: Icons.monetization_on_outlined,
                listiconcolor: Colors.red.shade800,
                listtextcolor: Colors.red.shade800,
                title: "Salary Slip",
                ontap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
