import 'dart:convert';
import 'dart:io';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/About.dart';
import 'package:medyq_patient/Widget/facebookWidget.dart';
import 'package:medyq_patient/screens/healthInfo.dart';
import 'package:medyq_patient/screens/models/labtestsClass.dart';
import 'package:medyq_patient/screens/models/allergiesClass.dart';
import 'package:medyq_patient/screens/models/dependantsClass.dart';
import 'package:medyq_patient/screens/models/invoiceClass.dart';
import 'package:medyq_patient/screens/models/nextOfKinClass.dart';
import 'package:medyq_patient/screens/models/prescriptionClass.dart';
import 'package:medyq_patient/screens/models/schemesClass.dart';
import 'package:medyq_patient/screens/resources.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'appointments.dart';
import 'authenticate/login.dart';
import 'authenticate/profile.dart';

class AppointmentsDetails extends StatefulWidget {
  final String token, title, facility, patientID;
  AppointmentsDetails(
      {Key key, this.title, this.token, this.facility, this.patientID})
      : super(key: key);

  @override
  _AppointmentsDetailsState createState() => _AppointmentsDetailsState();
}

class _AppointmentsDetailsState extends State<AppointmentsDetails> {
  int currentTab = 1;
  List<TabData> tabs = [
    TabData(iconData: Icons.home, title: "Profile"),
    TabData(iconData: Icons.calendar_today, title: "Appointments"),
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.info, title: "About")
  ];
  Future<List<PrescriptionsClass>> _prescriptions;
  Future<List<LabTestsClass>> _labtests;
  Future<List<InvoiceClass>> _invoices;
  @override
  void initState() {
    String facility = widget.facility;
    String token = widget.token;
    String patientID = widget.patientID;
    super.initState();
    _prescriptions = getPrescriptions(token, facility, patientID, context);
    _labtests = getLabTests(token, facility, patientID, context);
    _invoices = getInvoices(token, facility, patientID, context);
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
                }),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.green),
              title: Text('Appointments'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pop(context);
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
        title: Text('Appointments Details'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 1, 5, 5),
          child: Column(
            children: [
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
              //]),
              SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.white,
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'PRESCRIPTIONS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: new FutureBuilder<List<PrescriptionsClass>>(
                                future: _prescriptions,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<PrescriptionsClass> yourPosts =
                                        snapshot.data;
                                    if (yourPosts.isEmpty ||
                                        yourPosts == null ||
                                        yourPosts == [] ||
                                        yourPosts.length == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('NO PRESCRIPTIONS'),
                                      );
                                    } else {
                                      return new ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: yourPosts.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // Whatever sort of things you want to build
                                            // with your Post object at yourPosts[index]:
                                            if (yourPosts.isEmpty ||
                                                yourPosts == null ||
                                                yourPosts == [] ||
                                                yourPosts.length == 0) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text('NONE'),
                                              );
                                            } else {
                                              return ExpansionTile(
                                                initiallyExpanded: false,
                                                title: Text(yourPosts[index]
                                                        .brandName
                                                        .toString() +
                                                    '\t' +
                                                    yourPosts[index]
                                                        .brandName
                                                        .toString()),
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Relation: ' +
                                                                yourPosts[index]
                                                                    .code
                                                                    .toString()),
                                                            Text('Phone Number: ' +
                                                                yourPosts[index]
                                                                    .description
                                                                    .toString()),
                                                            Text('Email: ' +
                                                                yourPosts[index]
                                                                    .dispensed
                                                                    .toString()),
                                                            Text('Residence: ' +
                                                                yourPosts[index]
                                                                    .dosage
                                                                    .toString()),
                                                            Text('ID Number: ' +
                                                                yourPosts[index]
                                                                    .dosageInstructions
                                                                    .toString()),
                                                            SizedBox(
                                                              height: 10,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              );
                                            }
                                          });
                                    }
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  // By default, show a loading spinner.
                                  return LinearProgressIndicator();
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'LAB TESTS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: new FutureBuilder<List<LabTestsClass>>(
                                future: _labtests,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<LabTestsClass> yourPosts =
                                        snapshot.data;
                                    if (yourPosts.isEmpty ||
                                        yourPosts == null ||
                                        yourPosts == [] ||
                                        yourPosts.length == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('NO LAB TESTS'),
                                      );
                                    } else {
                                      return new ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: yourPosts.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // Whatever sort of things you want to build
                                            // with your Post object at yourPosts[index]:

                                            return ExpansionTile(
                                              title: Text(yourPosts[index]
                                                      .name
                                                      .toString() +
                                                  '\t' +
                                                  yourPosts[index]
                                                      .name
                                                      .toString()),
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Relation: ' +
                                                              yourPosts[index]
                                                                  .notes
                                                                  .toString()),
                                                          Text('Phone Number: ' +
                                                              yourPosts[index]
                                                                  .completed
                                                                  .toString()),
                                                          Text('Email: ' +
                                                              yourPosts[index]
                                                                  .result
                                                                  .toString()),
                                                          Text('Residence: ' +
                                                              yourPosts[index]
                                                                  .labTestId
                                                                  .toString()),
                                                          Text('ID Number: ' +
                                                              yourPosts[index]
                                                                  .createdBy
                                                                  .toString()),
                                                          SizedBox(
                                                            height: 10,
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ],
                                              //  ),
                                            );
                                          });
                                    }
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  // By default, show a loading spinner.
                                  return LinearProgressIndicator();
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'INVOICES',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: new FutureBuilder<List<InvoiceClass>>(
                                future: _invoices,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<InvoiceClass> yourPosts =
                                        snapshot.data;
                                    if (yourPosts.isEmpty ||
                                        yourPosts == null ||
                                        yourPosts == [] ||
                                        yourPosts.length == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('NO INVOICES'),
                                      );
                                    } else {
                                      return new ListView.builder(
                                          // scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: yourPosts.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // Whatever sort of things you want to build
                                            // with your Post object at yourPosts[index]:

                                            return Expanded(
                                              child: ExpansionTile(
                                                title: Text(yourPosts[index]
                                                    .name
                                                    .toString()),
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Payment Method: ' +
                                                                yourPosts[index]
                                                                    .coalesce
                                                                    .toString()),
                                                            Text('Quantity: ' +
                                                                yourPosts[index]
                                                                    .quantity
                                                                    .toString()),
                                                            Text('Amount Paid: ' +
                                                                yourPosts[index]
                                                                    .amountPaid
                                                                    .toString()),
                                                            Text('Dispensed: ' +
                                                                yourPosts[index]
                                                                    .dispensed
                                                                    .toString()),
                                                            SizedBox(
                                                              height: 10,
                                                            )
                                                          ],
                                                        )),
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
                                  return LinearProgressIndicator();
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 1,
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

  Future<List<PrescriptionsClass>> getPrescriptions(
      facility, token, patientID, context) async {
    var url =
        'http://medyq-test.mhealthkenya.co.ke/api/prescriptions/$patientID';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $facility"},
        body: {"facility": '$token'});
    print(response.body);
    return List<PrescriptionsClass>.from(
        json.decode(response.body).map((x) => PrescriptionsClass.fromJson(x)));
  }

  Future<List<LabTestsClass>> getLabTests(
      facility, token, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/lab-tests/$patientID';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $facility"},
        body: {"facility": '$token'});
    print(response.body);
    return List<LabTestsClass>.from(
        json.decode(response.body).map((x) => LabTestsClass.fromJson(x)));
  }

  Future<List<InvoiceClass>> getInvoices(
      facility, token, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/invoices/$patientID';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $facility"},
        body: {"facility": '$token'});
    print(response.body);
    return List<InvoiceClass>.from(
        json.decode(response.body).map((x) => InvoiceClass.fromJson(x)));
  }

  Future<bool> _logout(BuildContext context) {
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
