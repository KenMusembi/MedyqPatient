import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/About.dart';
import 'package:medyq_patient/screens/dependants.dart';
import 'package:medyq_patient/screens/models/allergiesClass.dart';
import 'package:medyq_patient/screens/models/dependantsClass.dart';
import 'package:medyq_patient/screens/models/nextOfKinClass.dart';
import 'package:medyq_patient/screens/models/schemesClass.dart';
import 'package:medyq_patient/screens/resources.dart';
import '../appointments.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  final String facilitySchema, token, title, patientID;
  Profile(
      {Key key, this.title, this.facilitySchema, this.token, this.patientID})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<AllergiesClass>> _allergies;
  Future<List<NextofKinClass>> _nextofkin;
  Future<List<DependantsClass>> _dependants;
  Future<List<SchemesClass>> _schemes;
  @override
  void initState() {
    String facility = widget.facilitySchema;
    String token = widget.token;
    String patientID = widget.patientID;
    super.initState();
    _allergies = _getAllergies(token, facility, patientID, context);
    _nextofkin = _getNextofKin(token, facility, patientID, context);
    _dependants = _getDependants(token, facility, patientID, context);
    _schemes = _getSchemes(token, facility, patientID, context);
  }

  @override
  Widget build(BuildContext context) {
    String facility = widget.facilitySchema;
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
                leading: Icon(Icons.person),
                title: Text('Patient Details'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
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
                leading: Icon(Icons.question_answer),
                title: Text('Appointments'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Appointments(facility: facility, token: token)));
                },
              ),
              ListTile(
                leading: Icon(Icons.collections_bookmark),
                title: Text('About App'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
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
        body: Container(
          child: SingleChildScrollView(
            //color: Colors.grey,
            //height: height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 10.0,
                    child: InkWell(
                      focusColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Appointments(
                                    facility: facility, token: token)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 25,
                          child: Text('Appointments',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 10.0,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          //height: 50,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'VITALS',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(children: [
                                    Text('NONE'),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 10.0,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          //height: 50,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text('CONDITIONS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Row(children: [
                                    Text('NONE'),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '\n \t  NEXT OF KIN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 100,
                    // flex: 2,
                    child: new FutureBuilder<List<NextofKinClass>>(
                        future: _nextofkin,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<NextofKinClass> yourPosts = snapshot.data;
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
                                        label: Text('Relationship',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('Residence',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('Status',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                  ], rows: [
                                    DataRow(cells: [
                                      DataCell(Text(yourPosts[index]
                                          .firstName
                                          .toString())),
                                      DataCell(Text(yourPosts[index]
                                          .lastName
                                          .toString())),
                                      DataCell(Text(
                                          yourPosts[index].title.toString())),
                                      DataCell(Text(yourPosts[index]
                                          .residence
                                          .toString())),
                                      DataCell(Text(
                                          yourPosts[index].status.toString())),
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
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                        //  flex: 4,
                        child: new FutureBuilder<List<AllergiesClass>>(
                            future: _allergies,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<AllergiesClass> yourPosts = snapshot.data;
                                return new ListView.builder(
                                    itemCount: yourPosts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // Whatever sort of things you want to build
                                      // with your Post object at yourPosts[index]:

                                      return Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'ALLERGIES',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  ListTile(
                                                    enabled: true,
                                                    //  isThreeLine: true,
                                                    onTap: () {},

                                                    title: Text('Allergy:\t' +
                                                        yourPosts[index]
                                                            .allergyId
                                                            .toString()),
                                                    subtitle: Text(
                                                        'Date Noted:\t' +
                                                            yourPosts[index]
                                                                .updatedAt
                                                                .toString()),
                                                    //trailing: Text(hh[index].toString()),
                                                  ),

                                                  // ),
                                                  // Text(resources[index].heading)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              // By default, show a loading spinner.

                              return LinearProgressIndicator();
                            }),
                      ),
                    ],
                  ),
                  Text(
                    '\n \t  DEPNDANTS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 100,
                    // flex: 2,
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
                                        label: Text('Relationship',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('Email',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('Status',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                  ], rows: [
                                    DataRow(cells: [
                                      DataCell(Text(yourPosts[index]
                                          .firstName
                                          .toString())),
                                      DataCell(Text(yourPosts[index]
                                          .lastName
                                          .toString())),
                                      DataCell(Text(
                                          yourPosts[index].title.toString())),
                                      DataCell(Text(
                                          yourPosts[index].email.toString())),
                                      DataCell(Text(
                                          yourPosts[index].status.toString())),
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
                  Card(
                    color: Colors.white,
                    elevation: 10.0,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          //height: 50,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'ATTACHEMNTS',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Row(children: [
                                    Text(''),
                                    SizedBox(width: 10.0),
                                    Text('NONE'),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '\n \t  INSURANCE SCHEMES',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 100,
                    // flex: 2,
                    child: new FutureBuilder<List<SchemesClass>>(
                        future: _schemes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<SchemesClass> yourPosts = snapshot.data;
                            return new ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: yourPosts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // Whatever sort of things you want to build
                                  // with your Post object at yourPosts[index]:

                                  return DataTable(columns: [
                                    DataColumn(
                                        label: Text('Scheme Name',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('Member Number',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                  ], rows: [
                                    DataRow(cells: [
                                      DataCell(Text(
                                          yourPosts[index].name.toString())),
                                      DataCell(Text(yourPosts[index]
                                          .memberNumber
                                          .toString())),
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
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ));
  }

  Future<List<AllergiesClass>> _getAllergies(
      token, facility, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/allergies/316';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": facility});
    List<dynamic> data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);

    int usersPhoneNumber = data[0]['allergy_id'];
    print(usersPhoneNumber.toString());

    return List<AllergiesClass>.from(
        json.decode(response.body).map((x) => AllergiesClass.fromJson(x)));
  }

  Future<List<NextofKinClass>> _getNextofKin(
      token, facility, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/next-of-kin/1001';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": facility});
    List<dynamic> data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);

    int usersPhoneNumber = data[0]['allergy_id'];
    print(usersPhoneNumber.toString());

    return List<NextofKinClass>.from(
        json.decode(response.body).map((x) => NextofKinClass.fromJson(x)));
  }

  Future<List<DependantsClass>> _getDependants(
      token, facility, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/dependants/316';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": facility});
    List<dynamic> data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);

    int usersPhoneNumber = data[0]['allergy_id'];
    print(usersPhoneNumber.toString());

    return List<DependantsClass>.from(
        json.decode(response.body).map((x) => DependantsClass.fromJson(x)));
  }

  Future<List<SchemesClass>> _getSchemes(
      token, facility, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/schemes/1';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": facility});
    List<dynamic> data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);

    int usersPhoneNumber = data[0]['allergy_id'];
    print(usersPhoneNumber.toString());

    return List<SchemesClass>.from(
        json.decode(response.body).map((x) => SchemesClass.fromJson(x)));
  }
}

/*
  facilitySchema = data['facility_visits'][0];
  facilityName = data['facility_visits'][1]['name'];
  facilityNumber = data['facility_visits'][1]['number'];
  facilityCreatedAt = data['facility_visits'][1]['creadted_at'];
  print(facilityName + '\n' + facilityNumber);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Profile(facilityName: facilityName, token: token)));*/

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
/*
Future getProfile(token) async {
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/user';
  //var token;
  Response response = await get(
    url,
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  Map data = jsonDecode(response.body);
  print(response);
  print('object');
  print(data);

  String usersPhoneNumber = data['user']['phone_number'];
  print(usersPhoneNumber.toString());

  return (usersPhoneNumber.toString());
  /*
  facilitySchema = data['facility_visits'][0];
  facilityName = data['facility_visits'][1]['name'];
  facilityNumber = data['facility_visits'][1]['number'];
  facilityCreatedAt = data['facility_visits'][1]['creadted_at'];
  print(facilityName + '\n' + facilityNumber);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Profile(facilityName: facilityName, token: token)));*/
}*/
