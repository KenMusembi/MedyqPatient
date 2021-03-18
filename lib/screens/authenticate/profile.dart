import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/About.dart';
import 'package:medyq_patient/screens/appointments.dart';
import 'package:medyq_patient/screens/dependants.dart';
import 'package:medyq_patient/Widget/facebookWidget.dart';
import 'package:medyq_patient/screens/healthInfo.dart';
import 'package:medyq_patient/screens/insuranceSchemes.dart';
import 'package:medyq_patient/screens/models/profileClass.dart';
import 'package:medyq_patient/screens/nextOfKin.dart';
import 'package:medyq_patient/screens/resources.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  final String token, title, facility, patientID;
  Profile({Key key, this.title, this.token, this.facility, this.patientID})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<ProfileClass> _profile;
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
    _profile = getProfile(token, context);
    super.initState();
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
                Icons.file_copy_rounded,
                color: Colors.green,
              ),
              title: Text('Patient Details'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.green),
              title: Text('Appointments'),
              onTap: () {
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
              leading: Icon(Icons.local_hospital, color: Colors.green),
              title: Text('Health Info'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HealthInfo(
                            facility: facility,
                            token: token,
                            patientID: patientID)));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.green,
              ),
              title: Text('Resources'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Resources()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.green,
              ),
              title: Text('About App'),
              onTap: () {
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
                Logout(context);
              },
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter, child: SocialButtons()))
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
              /*Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 5, 5),
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(color: Colors.green, width: 0),
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green[400],
                  child: Container(
                      /*decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.green[300], Colors.green[300]]),
                  ),*/
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.green.shade200,
                              minRadius: 45.0,
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9jdG9yJTIwYWZyaWNhbiUyMGFtZXJpY2FufGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                            ),
                            Icon(
                              Icons.settings,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        new FutureBuilder<ProfileClass>(
                            future: _profile,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                ProfileClass yourPosts = snapshot.data;
                                return new Column(children: [
                                  Text(yourPosts.number.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 2,
                                          wordSpacing: 2)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(yourPosts.phoneNumber.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(yourPosts.email.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1))
                                ]);
                                //Text(yourPosts.phoneNumber.toString());

                                // ),

                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              // By default, show a loading spinner.

                              return CircularProgressIndicator();
                            }),
                      
                      ],
                    ),
                  )),
                ),
              ),*/
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
                            width: MediaQuery.of(context).size.width / 2 - 20,
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
                                            backgroundColor: Colors.white,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.local_hospital,
                                              color: Color(0xffAAD4DA),
                                            ),
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
                            width: MediaQuery.of(context).size.width / 2 - 20,
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
                                            backgroundColor: Colors.white,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.schedule,
                                              color: Color(0xff8BC4C1),
                                            ),
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
                            width: MediaQuery.of(context).size.width / 2 - 20,
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
                                            backgroundColor: Colors.white,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.child_care,
                                              color: Color(0xff65A1A0),
                                            ),
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
                            width: MediaQuery.of(context).size.width / 2 - 20,
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
                                            backgroundColor: Colors.white,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.person_add,
                                              color: Color(0xff9FD0D4),
                                            ),
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
                            width: MediaQuery.of(context).size.width / 2 - 20,
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
                                            backgroundColor: Colors.white,
                                            minRadius: 25.0,
                                            child: Icon(
                                              Icons.inventory,
                                              color: Color(0xff87BDD6),
                                            ),
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
          return AlertDialog(
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
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      ) ??
      false;
}

Future<ProfileClass> getProfile(token, context) async {
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/user';
  Response response = await get(url,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
  dynamic data = jsonDecode(response.body);
  Map<String, dynamic> data2 = data['user'];
  print(data['user']);
  return ProfileClass.fromJson(data2);
}
