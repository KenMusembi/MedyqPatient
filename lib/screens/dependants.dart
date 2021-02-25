import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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

class Dependants extends StatefulWidget {
  final String token, title, facility;
  Dependants({Key key, this.title, this.token, this.facility})
      : super(key: key);

  @override
  _DependantsState createState() => _DependantsState();
}

class _DependantsState extends State<Dependants> {
  int currentTab = 0;
  List<TabData> tabs = [
    TabData(iconData: Icons.home, title: "Profile"),
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.info, title: "About"),
    TabData(iconData: Icons.exit_to_app, title: "Logout")
  ];
  Future<List<DependantsClass>> _dependants;
  @override
  void initState() {
    String facility = widget.facility;
    String token = widget.token;
    //String patientID = widget.patientID;
    super.initState();
    _dependants = getDependants(token, facility, context);
  }

  @override
  Widget build(BuildContext context) {
    // String facility = widget.facilitySchema;
    String token = widget.token;
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
                        builder: (context) =>
                            Appointments(facility: 'facility', token: token)));
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
        title: Text('Dependants'),
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
            child: new FutureBuilder<List<DependantsClass>>(
                future: _dependants,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DependantsClass> yourPosts = snapshot.data;
                    return new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: yourPosts.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Whatever sort of things you want to build
                          // with your Post object at yourPosts[index]:

                          return DataTable(columns: [
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
                                label: Text('Relation',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Phone',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Email',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Residence',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('ID Number',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('D.O.B',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ], rows: [
                            DataRow(cells: [
                              DataCell(
                                  Text(yourPosts[index].firstName.toString())),
                              DataCell(
                                  Text(yourPosts[index].lastName.toString())),
                              DataCell(Text(yourPosts[index].title.toString())),
                              DataCell(Text(
                                  yourPosts[index].phoneNumber.toString())),
                              DataCell(Text(yourPosts[index].email.toString())),
                              DataCell(
                                  Text(yourPosts[index].residence.toString())),
                              DataCell(
                                  Text(yourPosts[index].idNumber.toString())),
                              DataCell(Text(yourPosts[index].dob.toString())),
                            ]),
                          ]);
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.

                  return LinearProgressIndicator();
                }),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
                break;
              case 2:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));

                break;
              case 3:
                Logout(context);

                break;
              default:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Resources()));
            }
          });
        },
      ),
    );
  }

  Future<List<DependantsClass>> getDependants(facility, token, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/dependants/0093';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": 'demo_2019_08_23_181408'});
    setState(() {
      //  uuid = response.body[1];
    });
    //List data = jsonDecode(response.body);

    setState(() {
      //  uuid = data[0]['uuid'];
    });
    print(response.body);
    return List<DependantsClass>.from(
        json.decode(response.body).map((x) => DependantsClass.fromJson(x)));
  }

  Future<bool> Logout(BuildContext context) {
    return showDialog(
          context: context,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: AlertDialog(
              title: Text('Logout from MedyQ?'),
              content: Text('Are you sure you want to log out?'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.white)),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
                FlatButton(
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
            ),
          ),
        ) ??
        false;
  }
}
