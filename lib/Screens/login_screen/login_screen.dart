import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/Common/colors.dart';
import 'package:employee_attendance/Common/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/custom_widgets/buttons.dart';
import '../../Common/custom_widgets/textfield.dart';
import '../bottom_bar/bottombar.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController useridcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool ispasswordvisible = true;

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.only(
              top: 50.0, left: 10.0, right: 10.0),
          width: screenWidth(context),
          height: screenHeight(context),
          color: Second,
          child: Column(
            children: [
              const HeightGap(gap: 0.01),
              isKeyboardVisible
                  ? SizedBox(
                      height: screenHeight(context) * 0.01,
                    )
                  : SizedBox(
                      width: screenWidth(context),
                      height: screenHeight(context) * 0.3,
                      child: Image.asset(
                        fit: BoxFit.contain,
                        "lib/images/log-in.png",
                      ),
                    ),
              const HeightGap(gap: 0.05),
              Text(
                "Log In",
                style: TextStyle(
                    color: FirstAccent, fontSize: 30, fontFamily: "Main"),
              ),
              const HeightGap(gap: 0.1),
              Container(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                width: screenWidth(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: FirstAccent,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Mytextfield(
                      controller: useridcontroller,
                      Keyboardtype: TextInputType.text,
                      hint: 'User Id',
                      myicon: Icons.person,
                      maxLines: 1,
                    ),
                    const HeightGap(gap: 0.01),
                    Mytextfield(
                      controller: passcontroller,
                      Obscure: ispasswordvisible,
                      Keyboardtype: TextInputType.visiblePassword,
                      hint: "Password",
                      maxLines: 1,
                      myicon: Icons.lock_outline,
                      suffixbutton: IconButton(
                          onPressed: () {
                            setState(() {
                              ispasswordvisible = !ispasswordvisible;
                            });
                          },
                          icon: Icon(
                            ispasswordvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: FirstAccent,
                          )),
                    ),
                    const HeightGap(gap: 0.02),
                    myElevatedbutton(
                      onpress: () async {
                        FocusScope.of(context).unfocus();
                        String id = useridcontroller.text.trim();
                        String password = passcontroller.text.trim();

                        if (id.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please enter your User Id!!")));
                        } else if (password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please enter your Password!!")));
                        } else {
                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("User")
                              .where("id", isEqualTo: id)
                              .get();

                          try {
                            if (password == snap.docs[0]["password"]) {
                              sharedPreferences =
                                  await SharedPreferences.getInstance();

                              sharedPreferences.setString("userId", id).then((_) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BottomNavigate(),
                                    ));
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Password is incorrect!")));
                            }
                          } catch (e) {
                            String error = " ";
                            if (e.toString() ==
                                "RangeError (index): Invalid value: Valid value range is empty: 0") {
                              setState(() {
                                error = "User Id is does not exist!";
                              });
                            } else {
                              setState(() {
                                error = "Error Occurred!";
                              });
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(error)));
                          }
                        }
                      },
                      text: 'Login',
                    ),],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
