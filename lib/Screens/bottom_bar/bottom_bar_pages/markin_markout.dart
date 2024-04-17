import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance/Common/dimension.dart';
import 'package:employee_attendance/User/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../Common/colors.dart';

class MarkInMarkOut extends StatefulWidget {
  const MarkInMarkOut({super.key});

  @override
  State<MarkInMarkOut> createState() => _MarkInMarkOutState();
}

class _MarkInMarkOutState extends State<MarkInMarkOut> {
  String markIn = '--/--';
  String markOut = '--/--';
  String location = ' ';
  Set<Marker> marker = {};

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.1702, 72.8311),
    zoom: 14.4746,
  );

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Service are disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission Denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are Permnently Denied");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getlocation() async {
    List<Placemark> placemark = await placemarkFromCoordinates(MyUser.lat, MyUser.long);

    setState(() {
      location = "${placemark[0].name}, ${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}- ${placemark[0].postalCode}, ${placemark[0].administrativeArea}, ${placemark[0].country}";
    });
  }


  void _getRecord() async{
    try{
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('User')
          .where('id', isEqualTo: MyUser.employeeId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection('User')
          .doc(snap.docs[0].id)
          .collection("User Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        markIn = snap2['markIn'];
        markOut = snap2['markOut'];
      });
    }catch(e){

      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('User')
          .where('id', isEqualTo: MyUser.employeeId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection('User')
          .doc(snap.docs[0].id)
          .collection("User Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        markIn = markIn != null ? "--/--" : snap2['markIn'];
        markOut = markOut != null ? "--/--" : snap2['markOut'];
      });
    }
    print(markIn);
    print(markOut);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.fill,
                  image: AssetImage("lib/images/Sky.jpg"))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Wel Come, ' + MyUser.employeeId,
                  style: TextStyle(
                      fontFamily: 'Main1',
                      fontSize: 20,
                      color: newFirst,
                      fontWeight: FontWeight.w600),
                ),
              ),


              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(colors: [newSecond, newFirst]),
                    boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 5)]),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Mark In',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Main1',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  markIn,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Main',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Mark Out',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Main1',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  markOut,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Main',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              HeightGap(gap: 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                          text: DateTime.now().day.toString(),
                          style: TextStyle(
                              color: FirstAccent, fontSize: 18, fontFamily: 'Main'),
                          children: [
                            TextSpan(
                              text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                              style: TextStyle(
                                  color: First, fontSize: 20, fontFamily: 'Main'),
                            )
                          ]),
                    ),
                  ),
                  StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            DateFormat('hh:mm:ss a').format(DateTime.now()),
                            style: TextStyle(
                                fontFamily: 'Main1',
                                fontSize: 20,
                                color: First,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      }),
                ],
              ),
              const HeightGap(gap: 0.01),
              markOut ==  '--/--' ? Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Builder(builder: (context) {
                  final GlobalKey<SlideActionState> key = GlobalKey();
                  return SlideAction(
                    animationDuration: const Duration(milliseconds: 500),
                    text: markIn ==  '--/--' ? 'Slide to Mark In' : 'Slide to Mark Out',
                    reversed: markIn ==  '--/--' ? false : true,
                    textStyle:  TextStyle(
                        fontFamily: 'Main1',
                        fontSize: 20,
                        color: markIn ==  '--/--' ? newSecond : newFirst,
                        fontWeight: FontWeight.w600),
                    innerColor: markIn ==  '--/--' ? newSecond : newFirst,
                    outerColor: Colors.white,
                    sliderButtonIcon: Icon(Icons.keyboard_double_arrow_right_sharp, color: Colors.white,),
                    submittedIcon: Icon(
                      FontAwesomeIcons.checkDouble,
                      color: Second,
                    ),
                    key: key,
                    onSubmit: () async {
                        if(MyUser.lat != 0){
                          _getlocation();

                          Position position = await _determinePosition();
                          final GoogleMapController controller = await _controller.future;
                          await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom:  15.0)));
                          setState(() {
                            marker.clear();
                            marker.add(Marker(icon: BitmapDescriptor.defaultMarker, markerId: MarkerId("currentlocation"), position: LatLng(position.latitude, position.longitude), ));
                          });

                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection('User')
                              .where('id', isEqualTo: MyUser.employeeId)
                              .get();

                          DocumentSnapshot snap2 = await FirebaseFirestore.instance
                              .collection('User')
                              .doc(snap.docs[0].id)
                              .collection("User Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .get();

                          try{
                            String markIn = snap2["markIn"];
                            setState(() {
                              markOut = DateFormat('hh:mm').format(DateTime.now());
                            });
                            await FirebaseFirestore.instance
                                .collection('User')
                                .doc(snap.docs[0].id)
                                .collection("User Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .update({
                              'date': Timestamp.now(),
                              'markIn': markIn,
                              'markOut' : DateFormat('hh:mm').format(DateTime.now()),
                              'markInLocation': location

                            });
                          } catch(e) {
                            setState(() {
                              markIn = DateFormat('hh:mm').format(DateTime.now());
                            });
                            await FirebaseFirestore.instance
                                .collection('User')
                                .doc(snap.docs[0].id)
                                .collection("User Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .set({
                              'date': Timestamp.now(),
                              'markIn': DateFormat('hh:mm').format(DateTime.now()),
                              'markOut': '--/--',
                              'markOutLocation': location
                            });
                          }
                          key.currentState!.reset();
                        }else{
                          Timer( Duration(seconds: 3), () async {
                            _getlocation();

                            Position position = await _determinePosition();
                            final GoogleMapController controller = await _controller.future;
                            await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom:  17.0)));
                            setState(() {
                              marker.clear();
                              marker.add(Marker(icon: BitmapDescriptor.defaultMarker, markerId: MarkerId("currentlocation"), position: LatLng(position.latitude, position.longitude), ));
                            });

                            QuerySnapshot snap = await FirebaseFirestore.instance
                                .collection('User')
                                .where('id', isEqualTo: MyUser.employeeId)
                                .get();

                            DocumentSnapshot snap2 = await FirebaseFirestore.instance
                                .collection('User')
                                .doc(snap.docs[0].id)
                                .collection("User Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .get();

                            try{
                              String markIn = snap2["markIn"];
                              setState(() {
                                markOut = DateFormat('hh:mm').format(DateTime.now());
                              });
                              await FirebaseFirestore.instance
                                  .collection('User')
                                  .doc(snap.docs[0].id)
                                  .collection("User Record")
                                  .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                  .update({
                                'date': Timestamp.now(),
                                'markIn': markIn,
                                'markOut' : DateFormat('hh:mm').format(DateTime.now()),
                                'markInLocation': location

                              });
                            } catch(e) {
                              setState(() {
                                markIn = DateFormat('hh:mm').format(DateTime.now());
                              });
                              await FirebaseFirestore.instance
                                  .collection('User')
                                  .doc(snap.docs[0].id)
                                  .collection("User Record")
                                  .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                  .set({
                                'date': Timestamp.now(),
                                'markIn': DateFormat('hh:mm').format(DateTime.now()),
                                'markOut': '--/--',
                                'markOutLocation': location
                              });
                            }
                            key.currentState!.reset();
                          });
                        }
                    },
                  );
                }),
              ) : Container(
                margin: EdgeInsets.only(top: 31.0, bottom: 31.0),
                child: Text("You already Completed today's work",
                  style: const TextStyle(
                      fontFamily: 'Main1',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),),
              ),
              Container(
                width: screenWidth(context),
                height: screenHeight(context) * 0.477,
                child: GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: marker,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
