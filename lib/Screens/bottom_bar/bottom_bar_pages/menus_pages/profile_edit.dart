import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/Common/colors.dart';
import 'package:employee_attendance/Common/custom_widgets/buttons.dart';
import 'package:employee_attendance/Common/custom_widgets/textfield.dart';
import 'package:employee_attendance/Common/dimension.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailidcontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  TextEditingController birthdatecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  void pickProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    Reference reference = FirebaseStorage.instance
        .ref()
        .child("${MyUser.employeeId.toLowerCase()}_profilePic.jpg");

    await reference.putFile(File(image!.path));

    reference.getDownloadURL().then((value) async {
      setState(() {
        MyUser.profilePicLink = value;
      });
      await FirebaseFirestore.instance
          .collection("User")
          .doc(MyUser.id)
          .update({
        "profilePic": value,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.5,
              fit: BoxFit.fill,
              image: AssetImage("lib/images/Sky.jpg"),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isKeyboardVisible
                    ? SizedBox()
                    : Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 30.0),
                            alignment: Alignment.bottomCenter,
                            width: screenWidth(context),
                            height: screenHeight(context) * 0.22,
                            decoration: BoxDecoration(
                                color: SecondAccent,
                                gradient: LinearGradient(
                                    colors: [newSecond, newFirst]),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                  )
                                ]),
                          ),
                          Positioned(
                            right: screenWidth(context) * 0.3065,
                            bottom: 0,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                strokeAlign: BorderSide
                                                    .strokeAlignOutside,
                                                color: Colors.black),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2,
                                                  spreadRadius: 1)
                                            ]),
                                        child: ClipOval(
                                          child: MyUser.profilePicLink == " "
                                              ? Icon(
                                                  Icons.person,
                                                  size: 75,
                                                )
                                              : Image.network(
                                                  fit: BoxFit.fill,
                                                  MyUser.profilePicLink),
                                        )),
                                    Positioned(
                                      bottom: 8,
                                      right: 9,
                                      child: GestureDetector(
                                        onTap: () {
                                          pickProfilePic();
                                        },
                                        child: Container(
                                          child: Icon(
                                            Icons.photo_camera,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                HeightGap(gap: 0.005),
                                Text(
                                  "Id : " +MyUser.employeeId,
                                  style: const TextStyle(
                                      fontFamily: 'Main1',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                const HeightGap(gap: 0.01),
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 8.0, bottom: 10.0),
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      const HeightGap(gap: 0.01),
                      Mytextfield(
                        controller: firstnamecontroller,
                        Keyboardtype: TextInputType.text,
                        hint: "First Name",
                        maxLines: 1,
                        myicon: Icons.person_outline_outlined,
                      ),
                      const HeightGap(gap: 0.01),
                      Mytextfield(
                        controller: lastnamecontroller,
                        Keyboardtype: TextInputType.text,
                        hint: "Last Name",
                        maxLines: 1,
                        myicon: Icons.person_outline_outlined,
                      ),
                      const HeightGap(gap: 0.01),
                      Mytextfield(
                        controller: emailidcontroller,
                        Keyboardtype: TextInputType.emailAddress,
                        hint: "Email Address",
                        maxLines: 1,
                        myicon: Icons.email_outlined,
                      ),
                      const HeightGap(gap: 0.01),
                      Mytextfield(
                        controller: phonenumbercontroller,
                        Keyboardtype: TextInputType.phone,
                        maxchar: 10,
                        maxLines: 1,
                        hint: "Phone Number",
                        myicon: Icons.phone_outlined,
                      ),
                      const HeightGap(gap: 0.01),
                      Mytextfield(
                          controller: designationcontroller,
                          Keyboardtype: TextInputType.text,
                          myicon: Icons.work_outline,
                          hint: "Designation"
                      ),
                      const HeightGap(gap: 0.01),
                      Mytextfield(
                        maxLines: 1,
                        OnTap: () async {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          ).then((value) {
                            setState(() {
                              birthdatecontroller.text =
                                  DateFormat('dd/MM/yyyy').format(value!);
                            });
                          });
                        },
                        ReadOnly: true,
                        controller: birthdatecontroller,
                        Keyboardtype: TextInputType.text,
                        hint: "Date of Birth",
                        myicon: Icons.calendar_today,
                      ),
                      const HeightGap(gap: 0.01),
                      Mytextfield(
                        controller: addresscontroller,
                        Keyboardtype: TextInputType.text,
                        hint: "Address",
                        maxLines: 1,
                        myicon: Icons.location_on_outlined,
                      ),
                      const HeightGap(gap: 0.01),
                      myElevatedbutton(
                        onpress: () async {
                          String firstName = firstnamecontroller.text;
                          String lastName = lastnamecontroller.text;
                          String emailId = emailidcontroller.text;
                          String phoneNumber = phonenumbercontroller.text;
                          String designation = designationcontroller.text;
                          String birthDate = birthdatecontroller.text;
                          String address = addresscontroller.text;

                          if (firstName.isEmpty) {
                            return showSnakeBar("Please Enter First Name");
                          } else if (lastName.isEmpty) {
                            return showSnakeBar("Please Enter Last Name");
                          } else if (emailId.isEmpty) {
                            return showSnakeBar("Please Enter Email Address");
                          } else if (phoneNumber.isEmpty) {
                            return showSnakeBar("Please Enter Phone Number");
                          }  else if (designation.isEmpty) {
                            return showSnakeBar("Please Enter Designation");
                          } else if (birthDate.isEmpty) {
                            return showSnakeBar("Please Enter Date of Birth");
                          } else if (address.isEmpty) {
                            return showSnakeBar("Please Enter Address");
                          } else {
                            await FirebaseFirestore.instance
                                .collection("User")
                                .doc(MyUser.id)
                                .update({
                              "firstName": firstName,
                              "lastName": lastName,
                              "emailId": emailId,
                              "phoneNum": phoneNumber,
                              "designation": designation,
                              "BirthDate": birthDate,
                              "address": address,
                            }).then((value) {
                              setState(() {
                                MyUser.firstName = firstName;
                                MyUser.lastName = lastName;
                                MyUser.emailAddress = emailId;
                                MyUser.phoneNumber = phoneNumber;
                                MyUser.designation = designation;
                                MyUser.birthDate = birthDate;
                                MyUser.address = address;
                              });
                            });
                            Navigator.pop(context);
                            return showSnakeBar(
                                "Your data can be saved successfully.");
                          }
                        },
                        text: "Save",
                      ),
                      HeightGap(gap: 0.01),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnakeBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
    ));
  }
}
