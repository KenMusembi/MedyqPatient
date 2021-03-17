import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/About.dart';
import 'package:medyq_patient/screens/models/allergiesClass.dart';
import 'package:medyq_patient/screens/models/dependantsClass.dart';
import 'package:medyq_patient/screens/models/nextOfKinClass.dart';
import 'package:medyq_patient/screens/models/schemesClass.dart';
import 'package:medyq_patient/screens/resources.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'appointments.dart';
import 'authenticate/login.dart';
import 'authenticate/profile.dart';

void main() {
  runApp(HealthInfo());
}

class HealthInfo extends StatefulWidget {
  HealthInfo({Key key, this.title, this.token, this.facility, this.patientID})
      : super(key: key);
  final String token, title, facility, patientID;
  @override
  _HealthInfoState createState() => _HealthInfoState();
}

class _HealthInfoState extends State<HealthInfo> {
  int currentTab = 0;
  List<TabData> tabs = [
    TabData(iconData: Icons.home, title: "Profile"),
    TabData(iconData: Icons.calendar_today, title: "Appointments"),
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.info, title: "About")
  ];
  Future<List<AllergiesClass>> _allergies;
  @override
  void initState() {
    super.initState();
    String facility = widget.facility;
    String token = widget.token;
    String patientID = widget.patientID;
    _allergies = getAllergies(token, facility, patientID, context);
  }

  @override
  Widget build(BuildContext context) {
    String facility = widget.facility;
    String token = widget.token;
    String patientID = widget.patientID;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
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
                            patientID: patientID,
                            token: token)));
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
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('Health Information'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 1, 5, 5),
          child: Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.accessibility,
                    color: Colors.green,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vitals',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text('None'),
                  onTap: () {},
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[100],
                ),
                ListTile(
                  leading: Icon(
                    Icons.local_hospital,
                    color: Colors.green,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Conditions',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text('None'),
                  onTap: () {},
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[100],
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(
                      Icons.mood_bad,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Allergies',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    subtitle: new FutureBuilder<List<AllergiesClass>>(
                        future: _allergies,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == [] ||
                                snapshot.data.length == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('None'),
                              );
                            } else {
                              List<AllergiesClass> yourPosts = snapshot.data;
                              return new ListView.builder(
                                  itemCount: yourPosts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // Whatever sort of things you want to build
                                    // with your Post object at yourPosts[index]:

                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            enabled: true,
                                            hoverColor: Colors.green,
                                            autofocus: true,
                                            contentPadding:
                                                EdgeInsets.fromLTRB(5, 5, 5, 0),
                                            onTap: () {},
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  yourPosts[index]
                                                      .allergyId
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey[500],
                                                    //fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            height: 2,
                                            thickness: 2,
                                            color: Colors.grey[200],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.

                          return CircularProgressIndicator();
                        }),
                    onTap: () {
                      // Logout(context);
                    },
                  ),
                ),
                /* SizedBox(
                  height: _allergies.toString().length.toDouble() + 100,
                  child: ListTile(
                    leading: Icon(
                      Icons.mood_bad,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Allergies',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    subtitle: new FutureBuilder<List<AllergiesClass>>(
                        future: _allergies,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == []) {
                              return Text('None');
                            } else {
                              List<AllergiesClass> yourPosts = snapshot.data;
                              double heightr = yourPosts.length.toDouble();
                              //double height = heightr * 100;
                              return SizedBox(
                                height: heightr * 200,
                                child: new ListView.builder(
                                    itemCount: yourPosts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // Whatever sort of things you want to build
                                      // with your Post object at yourPosts[index]:
                                      if (_allergies == []) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "One of the fields is empty. \n Please make sure you have entered your details.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER_RIGHT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.amber[500],
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                enabled: true,
                                                hoverColor: Colors.green,
                                                autofocus: true,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        5, 5, 5, 0),
                                                onTap: () {},
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      yourPosts[index]
                                                          .allergyId
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        //fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                height: 2,
                                                thickness: 2,
                                                color: Colors.grey[200],
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    }),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else if (snapshot.data == []) {
                            Fluttertoast.showToast(
                                msg:
                                    "One of the fields is empty. \n Please make sure you have entered your details.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER_RIGHT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.amber[500],
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            Text('None');
                          }

                          // By default, show a loading spinner.

                          return CircularProgressIndicator();
                        }),
                    onTap: () {
                      // Logout(context);
                    },
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 0,
        circleColor: Colors.green,
        inactiveIconColor: Colors.green,
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

  Future<bool> _logout(BuildContext context) {
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
}

Future<List<AllergiesClass>> getAllergies(
    facility, token, patientID, context) async {
  print(token);
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/allergies/$patientID';
  Response response = await post(url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $facility'},
      body: {"facility": '$token'});

  print('jj' + response.body);
  print(patientID + facility + token);
  return List<AllergiesClass>.from(
      json.decode(response.body).map((x) => AllergiesClass.fromJson(x)));
}
