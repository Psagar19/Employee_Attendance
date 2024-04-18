import 'package:employee_attendance/Common/colors.dart';
import 'package:employee_attendance/Common/dimension.dart';
import 'package:employee_attendance/Screens/bottom_bar/bottombar.dart';
import 'package:employee_attendance/Screens/login_screen/login_screen.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _goHome();
    super.initState();
  }

  _goHome() async{
  await Future.delayed(const Duration(seconds: 5), () {});
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KeyboardVisibilityProvider(child: AuthCheck())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.5,
                fit: BoxFit.fill,
                image: AssetImage("lib/images/Sky.jpg"))
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Lottie.asset('lib/lottie/Animation - 1709717538482.json'),
          ),
        ),
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if(sharedPreferences.getString("userId") != null){
        setState(() {
          MyUser.employeeId = sharedPreferences.getString("userId")!;
          userAvailable = true;
        });
      }
    }catch(e){
      setState(() {
        userAvailable = false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return userAvailable ? const BottomNavigate() : const LogInScreen();
  }
}
