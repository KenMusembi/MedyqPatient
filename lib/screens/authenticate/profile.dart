import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/About.dart';
import 'package:medyq_patient/screens/dependants.dart';
import 'package:medyq_patient/screens/healthInfo.dart';
import 'package:medyq_patient/screens/insuranceSchemes.dart';
import 'package:medyq_patient/screens/models/allergiesClass.dart';
import 'package:medyq_patient/screens/models/dependantsClass.dart';
import 'package:medyq_patient/screens/models/nextOfKinClass.dart';
import 'package:medyq_patient/screens/models/profileClass.dart';
import 'package:medyq_patient/screens/models/schemesClass.dart';
import 'package:medyq_patient/screens/nextOfKin.dart';
import 'package:medyq_patient/screens/resources.dart';
import 'package:url_launcher/url_launcher.dart';
import '../appointments.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  final String token, title, facility, patientID;
  Profile({Key key, this.title, this.token, this.facility, this.patientID})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int currentTab = 0;
  List<TabData> tabs = [
    TabData(iconData: Icons.home, title: "Profile"),
    TabData(iconData: Icons.calendar_today, title: "Appointments"),
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.info, title: "About")
  ];
  @override
  void initState() {
    String facility = widget.facility;
    String token = widget.token;
    String patientID = widget.patientID;
    super.initState();
  }

  Widget _facebookButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.white,
                // offset: Offset(2, 4),
                //blurRadius: 5,
                spreadRadius: 2)
          ],
          //gradient: LinearGradient(
          //begin: Alignment.centerLeft,
          // end: Alignment.centerRight,
          //colors: [Colors.white10, Colors.white])
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue[900]),
                onPressed: () {
                  launch('https://www.mhealthkenya.org/');
                }),
            IconButton(
                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                icon: Icon(FontAwesomeIcons.twitter, color: Colors.blue),
                onPressed: () {
                  launch('https://www.mhealthkenya.org/');
                }),
            IconButton(
                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                icon: Icon(FontAwesomeIcons.linkedin, color: Colors.blue[600]),
                onPressed: () {
                  launch('https://www.mhealthkenya.org/');
                }),
            IconButton(
                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                icon: Icon(FontAwesomeIcons.inbox, color: Colors.indigo[600]),
                onPressed: () {
                  launch('https://www.mhealthkenya.org/');
                }),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    String facility = widget.facility;
    String token = widget.token;
    String patientID = widget.patientID;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset('assets/logo.png'),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.green,
              ),
              title: Text('Patient Details'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.green,
              ),
              title: Text('Resources'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Resources()));
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.green),
              title: Text('Appointments'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Appointments(
                            facility: facility,
                            token: token,
                            patientID: patientID)));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.collections_bookmark,
                color: Colors.green,
              ),
              title: Text('About App'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.green,
              ),
              title: Text('Logout'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Logout(context);
              },
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _facebookButton()))
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('Patient Details'),
        centerTitle: true,
        elevation: 3,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () => Logout(context)),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Color(0xffB9DEDF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: InkWell(
                        splashColor: Colors.pink.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Appointments(
                                      facility: facility,
                                      token: token,
                                      patientID: patientID)));
                        },
                        child: Container(
                            //color: Colors.white,
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            // height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.white, //green.shade200,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.calendar_today,
                                              color: Color(0xffB9DEDF),
                                            ),
                                            //Icon: Icon(Icons.ac_unit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 35),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Appointments',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'view appointments',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Color(0xffAAD4DA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HealthInfo(
                                      facility: facility,
                                      token: token,
                                      patientID: patientID)));
                        },
                        child: Container(
                            //color: Colors.white,
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            // height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.white, //green.shade200,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.local_hospital,
                                              color: Color(0xffAAD4DA),
                                            ),
                                            //Icon: Icon(Icons.ac_unit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 35),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Health Info',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'view health info',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Color(0xff8BC4C1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: InkWell(
                        splashColor: Colors.pink.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InsuranceSchemes(
                                      facility: facility,
                                      token: token,
                                      patientID: patientID)));
                        },
                        child: Container(
                            //color: Colors.white,
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            // height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.white, //green.shade200,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.schedule,
                                              color: Color(0xff8BC4C1),
                                            ),
                                            //Icon: Icon(Icons.ac_unit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 35),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Schemes',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'insurance schemes',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Color(0xff65A1A0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dependants(
                                      facility: facility,
                                      patientID: patientID,
                                      token: token)));
                        },
                        child: Container(
                            //color: Colors.white,
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            // height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.white, //green.shade200,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.child_care,
                                              color: Color(0xff65A1A0),
                                            ),
                                            //Icon: Icon(Icons.ac_unit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 35),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dependants',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'view dependants info',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Color(0xff9FD0D4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: InkWell(
                        splashColor: Colors.pink.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NextofKin(
                                      facility: facility,
                                      patientID: patientID,
                                      token: token)));
                        },
                        child: Container(
                            //color: Colors.white,
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            // height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.white, //green.shade200,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.person_add,
                                              color: Color(0xff9FD0D4),
                                            ),
                                            //Icon: Icon(Icons.ac_unit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 35),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Next of Kin',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'view next of kin info',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Color(0xff87BDD6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          return Fluttertoast.showToast(
                              msg: "Feature Coming Soon...",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER_RIGHT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Container(
                            //color: Colors.white,
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            // height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.white, //green.shade200,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.inventory,
                                              color: Color(0xff87BDD6),
                                            ),
                                            //Icon: Icon(Icons.ac_unit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 35),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Invoices',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'view invoices',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 0,
        circleColor: Colors.green[400],
        inactiveIconColor: Colors.green[400],
        tabs: tabs,
        onTabChangedListener: (position) {
          setState(() {
            currentTab = position;
            print(currentTab);
            switch (position) {
              case 0:
                Navigator.pop(context);
                break;
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Appointments(
                            facility: facility,
                            patientID: patientID,
                            token: token)));
                break;
              case 2:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Resources()));
                break;
              case 3:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
                break;
              default:
                Navigator.pop(context);
            }
          });
        },
      ),
    );
  }
}

Future<bool> Logout(BuildContext context) {
  return showDialog(
        context: context,
        builder: (BuildContext context) {
          child:
          AlertDialog(
            title: Text('Logout from MedyQ?'),
            content: Text('Are you sure you want to log out?'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    //arguments: {},
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false,
                  );
                  //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      ) ??
      false;
}
