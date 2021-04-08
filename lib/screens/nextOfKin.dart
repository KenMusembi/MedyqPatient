import 'dart:convert';
import 'dart:io';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/About.dart';
import 'package:medyq_patient/Widget/facebookWidget.dart';
import 'package:medyq_patient/screens/healthInfo.dart';
import 'package:medyq_patient/screens/models/allergiesClass.dart';
import 'package:medyq_patient/screens/models/dependantsClass.dart';
import 'package:medyq_patient/screens/models/nextOfKinClass.dart';
import 'package:medyq_patient/screens/models/schemesClass.dart';
import 'package:medyq_patient/screens/resources.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'appointments.dart';
import 'authenticate/login.dart';
import 'authenticate/profile.dart';

class NextofKin extends StatefulWidget {
  NextofKin({Key key, this.title, this.token, this.facility, this.patientID})
      : super(key: key);
  final String token, title, facility, patientID;
  @override
  _NextofKinState createState() => _NextofKinState();
}

class _NextofKinState extends State<NextofKin> {
  int currentTab = 0;
  List<TabData> tabs = [
    TabData(iconData: Icons.home, title: "Profile"),
    TabData(iconData: Icons.calendar_today, title: "Appointments"),
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.info, title: "About")
  ];
  Future<List<NextofKinClass>> _nextofkin;
  @override
  void initState() {
    String facility = widget.facility;
    String token = widget.token;
    String patientID = widget.patientID;
    super.initState();
    _nextofkin = getNextofKin(token, facility, patientID, context);
  }

  @override
  Widget build(BuildContext context) {
    String facility = widget.facility;
    String patientID = widget.patientID;
    String token = widget.token;
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
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
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
              leading: Icon(Icons.local_hospital, color: Colors.green),
              title: Text('Health Info'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
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
                // Update the state of the app
                // ...
                // Then close the drawer
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
                    alignment: Alignment.bottomCenter, child: SocialButtons()))
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('Next of Kin'),
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
          child: new FutureBuilder<List<NextofKinClass>>(
              future: _nextofkin,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<NextofKinClass> yourPosts = snapshot.data;
                  return new ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: yourPosts.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Whatever sort of things you want to build
                        // with your Post object at yourPosts[index]:

                        return ExpansionTileCard(
                          expandedTextColor: Colors.green,
                          title: Text(yourPosts[index].firstName.toString() +
                              '\t' +
                              yourPosts[index].lastName.toString()),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Relation: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(yourPosts[index]
                                              .title
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Phone Number: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(yourPosts[index]
                                              .phoneNumber
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Email: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(yourPosts[index]
                                              .email
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Residence: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(yourPosts[index]
                                              .residence
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'ID Number: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(yourPosts[index]
                                              .idNumber
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        );
                        /*DataTable(columns: [
                          DataColumn(
                              label: Text('First Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Last Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Email',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Phone',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Hospital Number',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Relation',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ], rows: [
                          DataRow(cells: [
                            DataCell(
                                Text(yourPosts[index].firstName.toString())),
                            DataCell(
                                Text(yourPosts[index].lastName.toString())),
                            DataCell(Text(yourPosts[index].email.toString())),
                            DataCell(Text(
                                yourPosts[index].phoneNumber.toString())),
                            DataCell(
                                Text(yourPosts[index].number.toString())),
                            DataCell(Text(yourPosts[index].title.toString())),
                          ]),
                        ]);*/
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.

                return LinearProgressIndicator();
              }),
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
                        builder: (context) =>
                            Appointments(facility: 'facility', token: token)));
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

  Future<List<NextofKinClass>> getNextofKin(
      facility, token, patientID, context) async {
    var url =
        'http://demo.medyq-test.mhealthkenya.co.ke/api/next-of-kin/$patientID';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $facility"},
        body: {"facility": '$token'});

    print(response.body);
    return List<NextofKinClass>.from(
        json.decode(response.body).map((x) => NextofKinClass.fromJson(x)));
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
}
