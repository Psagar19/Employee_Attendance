import 'package:employee_attendance/Common/colors.dart';
import 'package:employee_attendance/Common/dimension.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.5,
              fit: BoxFit.fill,
              image: AssetImage("lib/images/Sky.jpg"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 30.0),
                    alignment: Alignment.bottomCenter,
                    width: screenWidth(context),
                    height: screenHeight(context) * 0.28,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [newSecond, newFirst]),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                          )
                        ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      alignment: Alignment.centerLeft,
                      width: screenWidth(context) * 0.5,
                      height: screenHeight(context) * 0.05,
                      child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    right: screenWidth(context) * 0.306,
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.black, width: 4)
                          ),
                          child: ClipOval(child: MyUser.profilePicLink == " " ? const Icon(Icons.person,size: 100,) : Image.network(fit: BoxFit.fill,
                              MyUser.profilePicLink),),
                        ),
                        const HeightGap(gap: 0.01),
                        Text(
                            "Id: ${MyUser.employeeId}",
                          style: const TextStyle(
                              fontFamily: 'Main1',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const HeightGap(gap: 0.04),
              Datacontainer(icon: Icons.person, title: 'Name', maintext: "${MyUser.firstName} ${MyUser.lastName}",),
              const HeightGap(gap: 0.01),
              Datacontainer(icon: Icons.email, title: "Email", maintext: MyUser.emailAddress),
              const HeightGap(gap: 0.01),
              Datacontainer(icon: Icons.phone, title: "Phone No.", maintext: MyUser.phoneNumber),
              const HeightGap(gap: 0.01),
              Datacontainer(icon: Icons.work, title: "Designation", maintext: MyUser.designation),
              const HeightGap(gap: 0.01),
              Datacontainer(icon: Icons.calendar_month_outlined, title: "BirthDate", maintext: MyUser.birthDate),
              const HeightGap(gap: 0.01),
              Datacontainer(icon: Icons.location_on, title: "Address", maintext: MyUser.address),

            ],
          ),
        ),
      ),
    );
  }
}

class Datacontainer extends StatelessWidget {
  const Datacontainer({
    super.key,
    required this.icon,
    required this.title,
    required this.maintext,
  });
  final IconData icon;
  final String title;
  final String maintext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: kToolbarHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth(context) * 0.1,
            height: screenWidth(context) * 0.1,
            margin: const EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: first
            ),
            child: Icon(icon, size: 22,color: Colors.white,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(
                  fontSize: screenHeight(context) * 0.016,
                  fontWeight: FontWeight.bold
              ),),
              Text(maintext,style: TextStyle(
                  fontSize: screenHeight(context) * 0.022,
                fontWeight: FontWeight.bold
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
