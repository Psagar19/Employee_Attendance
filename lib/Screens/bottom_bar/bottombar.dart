import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/Common/colors.dart';
import 'package:employee_attendance/Common/dimension.dart';
import 'package:employee_attendance/Screens/bottom_bar/bottom_bar_pages/markin_markout.dart';
import 'package:employee_attendance/Screens/bottom_bar/bottom_bar_pages/view_attendance.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:employee_attendance/service/location_service.dart';
import 'package:flutter/material.dart';

import 'bottom_bar_pages/menus.dart';


class BottomNavigate extends StatefulWidget {
  const BottomNavigate({super.key});

  @override
  State<BottomNavigate> createState() => _BottomNavigateState();
}

class _BottomNavigateState extends State<BottomNavigate> {
  int currentpage = 1;
  bool _currentPage = true;


  @override
  void initState() {
    super.initState();
    _startLocationservice();
    getId().then((value) {
      _getCredentials();
      _getprofilePic();

    });
  }
  void _getCredentials() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("User")
          .doc(MyUser.id).get();
      setState(() {
        MyUser.firstName = doc["firstName"];
        MyUser.lastName = doc["lastName"];
        MyUser.emailAddress = doc["emailId"];
        MyUser.phoneNumber = doc["phoneNum"];
        MyUser.birthDate = doc["BirthDate"];
        MyUser.address = doc["address"];
      });
    } catch(e) {
      return;
    }
  }

  void _getprofilePic() async {
    try{
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("User")
          .doc(MyUser.id).get();
      setState(() {
        MyUser.profilePicLink = doc["profilePic"];
      });
    }catch(e){
      MyUser.profilePicLink = " ";
      print(e.toString());
    }
  }

  void _startLocationservice() {
    LocationService().initialize();

    LocationService().getLongitude().then((value) {
      setState(() {
        MyUser.long = value!;
      });

      LocationService().getLatitude().then((value) {
        setState(() {
          MyUser.lat = value!;
        });
      });
    });
  }

  Future <void> getId() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('User')
        .where('id', isEqualTo: MyUser.employeeId)
        .get();

    setState(() {
      MyUser.id = snap.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentpage,
        children: [
          ViewAttendance(),
          MarkInMarkOut(),
          MenusPages(),
        ],
      ),
      bottomNavigationBar: Container(
        width: screenWidth(context),
        height: screenHeight(context) * 0.075,
        decoration: BoxDecoration(
          color: Second,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
              spreadRadius: 0.5
            )
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Second,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 10,
          selectedIconTheme: IconThemeData(
            color: _currentPage ? FirstAccent : First,
            size: _currentPage ? 30 : 10,
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.calendar_month),
                icon: Icon(Icons.calendar_today),
                label: " "),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: " "),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline_outlined),
                label: " "),
          ],
          currentIndex: currentpage,
          onTap: (index) {
            setState(() {
              currentpage = index;
            });
          },
        ),
      )
    );
  }
}