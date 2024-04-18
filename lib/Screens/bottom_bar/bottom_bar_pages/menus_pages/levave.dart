import 'package:employee_attendance/Common/custom_widgets/buttons.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:flutter/material.dart';

import '../../../../Common/colors.dart';
import '../../../../Common/dimension.dart';

class LevaveReqScr extends StatefulWidget {
  const LevaveReqScr({super.key});

  @override
  State<LevaveReqScr> createState() => _LevaveReqScrState();
}

class _LevaveReqScrState extends State<LevaveReqScr> {
  TextEditingController leavereasoncontroller = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  int _numberOfDays = 0;

  void _calculateNumberOfDays() {
    if (_startDate != null && _endDate != null) {
      setState(() {
        _numberOfDays = _endDate!.difference(_startDate!).inDays + 1;
      });
    } else {
      setState(() {
        _numberOfDays = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            height: screenHeight(context),
            width: screenWidth(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.5,
                fit: BoxFit.fill,
                image: AssetImage("lib/images/Sky.jpg"),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Apply for Leave Request",
                      style: TextStyle(
                          fontFamily: 'Main1',
                          fontSize: 20,
                          color: newFirst,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const HeightGap(gap: 0.05),
                  Container(
                    margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LeaveReqData(
                            title: "Your Name",
                            text: "${MyUser.firstName} ${MyUser.lastName}"),
                        const HeightGap(gap: 0.01),
                        LeaveReqData(
                            title: "Designation", text: MyUser.designation),
                        const HeightGap(gap: 0.01),
                        LeaveReqData(
                          onpressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050),
                            ).then((value) {
                              setState(() {
                                _startDate = value;
                                _calculateNumberOfDays();
                              });
                            });
                          },
                          title: "Start Date",
                          text: _startDate == null
                              ? 'Select Start Date'
                              : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                        ),
                        const HeightGap(gap: 0.01),
                        LeaveReqData(
                          onpressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _startDate ?? DateTime.now(),
                              firstDate: _startDate ?? DateTime.now(),
                              lastDate: DateTime(2050),
                            ).then((value) {
                              setState(() {
                                _endDate = value;
                                _calculateNumberOfDays();
                              });
                            });
                          },
                          title: "End Date",
                          text: _endDate == null
                              ? 'Select End Date'
                              : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                        ),
                        const HeightGap(gap: 0.01),
                        LeaveReqData(
                            title: "No. of Days", text: "$_numberOfDays"),
                        const HeightGap(gap: 0.01),
                        Text(
                          "Leave Reason",
                          style: TextStyle(
                              fontSize: screenHeight(context) * 0.018,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Main1"),
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: leavereasoncontroller,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter Leave Reason...",
                            hintStyle: TextStyle(
                                fontSize: screenHeight(context) * 0.017,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Main1"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.black)),
                          ),
                        ),
                        const HeightGap(gap: 0.01),
                        MyElevatedbutton(
                            onpress: () {
                              showSnakeBar("Leave Request can be Sent.");
                              Navigator.pop(context);
                            }, text: "Send Leave Request")
                      ],
                    ),
                  )
                ],
              ),
            )),
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

class LeaveReqData extends StatelessWidget {
  final String title;
  final String text;
  final Function()? onpressed;

  const LeaveReqData({
    super.key,
    required this.title,
    required this.text,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: screenHeight(context) * 0.018,
              fontWeight: FontWeight.bold,
              fontFamily: "Main1"),
        ),
        GestureDetector(
          onTap: onpressed,
          child: Container(
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            width: screenWidth(context),
            height: screenHeight(context) * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: screenHeight(context) * 0.017,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Main1",
                  color: newFirst),
            ),
          ),
        ),
      ],
    );
  }
}
