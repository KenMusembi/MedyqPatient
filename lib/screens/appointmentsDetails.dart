import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/Widget/bezierContainer.dart';
import 'package:medyq_patient/screens/labtestsClass.dart';
import 'package:medyq_patient/screens/models/prescriptionClass.dart';

import 'about.dart';
import 'authenticate/login.dart';
import 'authenticate/profile.dart';
import 'bookAppointment.dart';
import 'package:url_launcher/url_launcher.dart';

import 'resources.dart';

class AppointmentsDetails extends StatefulWidget {
  AppointmentsDetails({Key key, this.title, this.facility, this.token})
      : super(key: key);

  final String title, facility, token;

  @override
  _AppointmentsDetailsState createState() => _AppointmentsDetailsState();
}

class _AppointmentsDetailsState extends State<AppointmentsDetails> {
  Future<List<LabTestsClass>> _labtests;
  Future<List<PrescriptionsClass>> _prescriptions;
  @override
  void initState() {
    super.initState();
    String facility = widget.facility;
    String token = widget.token;
    _labtests = getLabTests(facility, token, context);
    _prescriptions = getPrescriptions(facility, token, context);
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _hospitalsCards() {
    return InkWell(
      child: Container(
        child: Card(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                // leading: Icon(Icons.album),
                title: Text('The Enchanted Nightingale'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
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
              leading: Icon(Icons.collections_bookmark),
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
        title: Text('Past Appointments'),
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
          child: SizedBox(
            height: height + 150,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _backButton(),

                          Text('Past Appointments',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          //  SizedBox(width: 10),
                          IconButton(
                              icon: Icon(Icons.person),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              }),
                        ],
                      ),*/
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
                                        'Vitals',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(children: [
                                        Text('None'),
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
                                      Text(
                                        'DIAGNOSES',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(children: [
                                        Text('Primary Diagnoses'),
                                        SizedBox(width: 10.0),
                                        Text('None'),
                                      ]),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        Text('Secondary Diagnosis'),
                                        SizedBox(width: 10.0),
                                        Text('None'),
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
                                      Text(
                                        'VISIT NOTE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        'SICK SHEETS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Row(children: [
                                        Text(''),
                                        SizedBox(width: 10.0),
                                        RaisedButton(
                                          onPressed: () {
                                            launch(
                                                'http://c4c-api.mhealthkenya.org/storage/uploads/1592985162HCWs%20risk%20assesment%20tool.docx');
                                          },
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              side: BorderSide(
                                                  color: Colors.green)),
                                          elevation: 10.0,
                                          textColor: Colors.white,
                                          child: Text('Download Sick Sheet'),
                                        ),
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
                                      Text(
                                        'INVOICE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Row(children: [
                                        Text(''),
                                        SizedBox(width: 10.0),
                                        RaisedButton(
                                          onPressed: () {
                                            launch(
                                                'http://c4c-api.mhealthkenya.org/storage/uploads/1592985162HCWs%20risk%20assesment%20tool.docx');
                                          },
                                          color: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              side: BorderSide(
                                                  color: Colors.blueAccent)),
                                          elevation: 10.0,
                                          textColor: Colors.white,
                                          child: Text('Download Invoice'),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: new FutureBuilder<List<LabTestsClass>>(
                      future: _labtests,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<LabTestsClass> yourPosts = snapshot.data;
                          return new ListView.builder(
                              itemCount: yourPosts.length,
                              itemBuilder: (BuildContext context, int index) {
                                // Whatever sort of things you want to build
                                // with your Post object at yourPosts[index]:

                                return Card(
                                  color: Colors.white,
                                  elevation: 10.0,
                                  child: InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Text(
                                              'LAB TESTS',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            ListTile(
                                              enabled: true,
                                              //  isThreeLine: true,
                                              onTap: () {},

                                              title: Text('Test Name:\t' +
                                                  yourPosts[index]
                                                      .name
                                                      .toString()),
                                              subtitle: Text('Result:\t' +
                                                  yourPosts[index]
                                                      .test
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

                        return CircularProgressIndicator();
                      }),
                ),
                /*
                Text(
                  'PRECRIPTIONS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), 
                Flexible(
                  flex: 1,
                  child: new FutureBuilder<List<PrescriptionsClass>>(
                      future: _prescriptions,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<PrescriptionsClass> yourPosts = snapshot.data;
                          return new ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: yourPosts.length,
                              itemBuilder: (BuildContext context, int index) {
                                // Whatever sort of things you want to build
                                // with your Post object at yourPosts[index]:

                                return DataTable(columns: [
                                  DataColumn(
                                      label: Text('Drug Name',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                  DataColumn(
                                      label: Text('Quantity',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                  DataColumn(
                                      label: Text('Dosage',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                  DataColumn(
                                      label: Text('Frequency',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                  DataColumn(
                                      label: Text('Dosage \n Instructions',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                  DataColumn(
                                      label: Text('Meal \n Instructions',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                  DataColumn(
                                      label: Text('Notes',
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
                                    DataCell(Text(
                                        yourPosts[index].brandName.toString())),
                                    DataCell(Text(
                                        yourPosts[index].quantity.toString())),
                                    DataCell(Text(
                                        yourPosts[index].dosage.toString())),
                                    DataCell(Text(
                                        yourPosts[index].frequency.toString())),
                                    DataCell(Text(yourPosts[index]
                                        .dosageInstructions
                                        .toString())),
                                    DataCell(Text(yourPosts[index]
                                        .mealInstructions
                                        .toString())),
                                    DataCell(Text(
                                        yourPosts[index].notes.toString())),
                                    DataCell(Text(
                                        yourPosts[index].status.toString())),
                                  ]),
                                ]);
                              });
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.

                        return CircularProgressIndicator();
                      }),
                ),*/
              ],
            ),
          ),
        ),
      ),
      // SizedBox(height: 10),
    );
  }
}

Future<List<LabTestsClass>> getLabTests(facility, token, context) async {
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/lab-tests/1';
  Response response = await post(url,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      body: {"facility": "$facility"});
  //Map<String, dynamic> data = jsonDecode(response.body);
  print(response.body);
  print(facility);
  return List<LabTestsClass>.from(
      json.decode(response.body).map((x) => LabTestsClass.fromJson(x)));
}

Future<List<PrescriptionsClass>> getPrescriptions(
    facility, token, context) async {
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/prescriptions/1';
  Response response = await post(url,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      body: {"facility": "$facility"});
  //Map<String, dynamic> data = jsonDecode(response.body);
  print(response.body);
  print(facility);
  return List<PrescriptionsClass>.from(
      json.decode(response.body).map((x) => PrescriptionsClass.fromJson(x)));
}

Future<bool> Logout(BuildContext context) {
  return showDialog(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: AlertDialog(
            title: Text('Logout from Medyq.'),
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
