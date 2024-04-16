import 'package:employee_attendance/Common/colors.dart';
import 'package:employee_attendance/Screens/bottom_bar/bottom_bar_pages/view_attendance.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../Screens/bottom_bar/bottom_bar_pages/menus_pages/userdetails.dart';
import '../../Screens/bottom_bar/bottom_bar_pages/menus_pages/profile_edit.dart';
import '../dimension.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("EmployeeId: "+ MyUser.employeeId),
            accountEmail: Text("Email Id: " + MyUser.emailAddress),
            currentAccountPicture: Container(
                width: screenWidth(context) * 0.1,
                height: screenHeight(context) * 0.1,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                    BorderRadius.circular(100),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                          spreadRadius: 1)
                    ]),
                child: ClipOval(
                  child: MyUser.profilePicLink == ""
                      ? Icon(Icons.person, size: 25,)
                      : Image.network(
                      fit: BoxFit.fill,
                      MyUser.profilePicLink),
                )),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => KeyboardVisibilityProvider(child: ProfileScreen()),));},
            title: Text(
              'Profile',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'drawer'
              ),),
            leading: Icon(Icons.person),
            splashColor: Second,
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAttendance(),));
              },
            leading: Icon( Icons.playlist_add_check_circle, ),
            splashColor: Second,
            title: Text(
              'Attendance View',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'drawer'
              ),),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon( Icons.calendar_today, ),
            splashColor: Second,
            title: Text(
              'Holiday List',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'drawer'
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon( Icons.pending_actions, ),
            title: Text(
              'Leave Request',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'drawer'
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon( Icons.monetization_on, ),
            title: Text(
              'Salary Slip',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'drawer'
              ),),
          ),
          Divider(),
        ]
      ),
    );
  }
}
