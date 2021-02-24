import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/labtestsClass.dart';
import 'package:medyq_patient/screens/models/invoiceClass.dart';
import 'package:medyq_patient/screens/models/prescriptionClass.dart';

import 'about.dart';
import 'authenticate/login.dart';
import 'authenticate/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'resources.dart';

class AppointmentsDetails extends StatefulWidget {
  AppointmentsDetails({Key key, this.title, this.facility, this.token})
      : super(key: key);

  final String title, facility, token;

  @override
  _AppointmentsDetailsState createState() => _AppointmentsDetailsState();
}

class _AppointmentsDetailsState extends State<AppointmentsDetails> {
  int currentTab = 1;
  List<TabData> tabs = [
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.book, title: "About"),
    TabData(iconData: Icons.exit_to_app, title: "Logout")
  ];
  String uuid;
  Future<List<LabTestsClass>> _labtests;
  Future<List<PrescriptionsClass>> _prescriptions;
  Future<List<InvoiceClass>> _invoices;
  @override
  void initState() {
    super.initState();
    String facility = widget.facility;
    String token = widget.token;
    _labtests = getLabTests(facility, token, context);
    _prescriptions = getPrescriptions(facility, token, context);
    _invoices = getInvoice(facility, token, context);
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
      body: ListView(
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
          Column(
            children: [
              SizedBox(
                height: 100,
                //  flex: 4,
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
                                      width: MediaQuery.of(context).size.width,
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

                      return LinearProgressIndicator();
                    }),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'INVOICES',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 200,
                child: new FutureBuilder<List<InvoiceClass>>(
                    future: _invoices,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<InvoiceClass> yourPosts = snapshot.data;
                        return new ListView.builder(
                            itemCount: yourPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              // Whatever sort of things you want to build
                              // with your Post object at yourPosts[index]:
                              String name = yourPosts[index].name;
                              return Card(
                                color: Colors.white,
                                elevation: 0.0,
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          RaisedButton(
                                            onPressed: () {
                                              launch(
                                                'http://demo.medyq-test.mhealthkenya.co.ke/invoices-print/1',
                                                headers: {
                                                  'facility': 'facility'
                                                },
                                                //body: {},
                                              );
                                            },
                                            color: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                    color: Colors.green)),
                                            //  elevation: 1.0,
                                            textColor: Colors.white,
                                            child: Text(
                                                'Download Invoice for $name'),
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
          Column(
            children: [
              Text(
                'PRECRIPTIONS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 100,
                // flex: 2,
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
                                  DataCell(
                                      Text(yourPosts[index].dosage.toString())),
                                  DataCell(Text(
                                      yourPosts[index].frequency.toString())),
                                  DataCell(Text(yourPosts[index]
                                      .dosageInstructions
                                      .toString())),
                                  DataCell(Text(yourPosts[index]
                                      .mealInstructions
                                      .toString())),
                                  DataCell(
                                      Text(yourPosts[index].notes.toString())),
                                  DataCell(
                                      Text(yourPosts[index].status.toString())),
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
            ],
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
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: Colors.green)),
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
        ],
      ),
      // SizedBox(height: 10),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Resources()));
                break;
              case 2:
                Logout(context);

                break;
              default:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
            }
          });
        },
      ),
    );
  }

  Future<List<PrescriptionsClass>> getPrescriptions(
      facility, token, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/prescriptions/1';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": "$facility"});
    setState(() {
      uuid = response.body[1];
    });
    List data = jsonDecode(response.body);

    setState(() {
      uuid = data[0]['uuid'];
    });
    return List<PrescriptionsClass>.from(
        json.decode(response.body).map((x) => PrescriptionsClass.fromJson(x)));
  }

  Future<List<InvoiceClass>> getInvoice(facility, token, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/invoices/1';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": "$facility"});
    List data = jsonDecode(response.body);
    setState(() {
      //name = data[0]['name'];
    });

    return List<InvoiceClass>.from(
        json.decode(response.body).map((x) => InvoiceClass.fromJson(x)));
  }
}

Future<List<LabTestsClass>> getLabTests(facility, token, context) async {
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/lab-tests/1';
  Response response = await post(url,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      body: {"facility": "$facility"});

  return List<LabTestsClass>.from(
      json.decode(response.body).map((x) => LabTestsClass.fromJson(x)));
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
