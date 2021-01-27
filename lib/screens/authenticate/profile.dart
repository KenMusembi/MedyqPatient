import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/dependants.dart';

import '../appointments.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  final String facilityName, token;
  Profile({Key key, this.title, this.facilityName, this.token})
      : super(key: key);

  final String title;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        body: SingleChildScrollView(
      //color: Colors.grey,
      //height: height,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _backButton(),
                    Text('Profile',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    //  SizedBox(width: 10),
                    IconButton(
                        icon: Icon(Icons.exit_to_app),
                        iconSize: 32,
                        onPressed: () {
                          Logout(context);
                        })
                  ],
                ),
                Positioned(
                  top: 100,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      Text('Kennedy Musembi'),
                      Text('+254748050434'),
                      SizedBox(height: 10.0),
                      Card(
                        color: Colors.white,
                        elevation: 10.0,
                        child: InkWell(
                          focusColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Appointments()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 25,
                              child: Text('Appointments - Upcoming and Past',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        'ALLERGIES',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        Text('Allregic to Nuts:'),
                                        SizedBox(width: 10.0),
                                        Text('Severe'),
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
                                        'NEXT OF KIN',
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
                                        'DEPENDANTS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text('scroll horizontally for details'),
                                      SizedBox(height: 5),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        height: 100.0,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          //scrollDirection: Axis.vertical,
                                          children: <Widget>[
                                            DataTable(
                                              columns: [
                                                DataColumn(
                                                    label: Text('Name',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text('ID TYPE',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text('ID NUMBER',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text('PHONE NUMBER',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text('RESIDENCE',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text('ACTIONS',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ],
                                              rows: [
                                                DataRow(cells: [
                                                  DataCell(Text('Ken Musembi')),
                                                  DataCell(Text('ID')),
                                                  DataCell(Text('34872130')),
                                                  DataCell(Text('0748050434')),
                                                  DataCell(Text(
                                                      '486 Homenick Plain Lake Amiyastad, VA 87146')),
                                                  DataCell(
                                                    RaisedButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .blueAccent)),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Dependants()));
                                                      },
                                                      color: Colors.blue,
                                                      elevation: 3.0,
                                                      textColor: Colors.white,
                                                      child: Text(
                                                          'View Appointments'),
                                                    ),
                                                  ),
                                                ]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
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
                                        'ATTACHEMNTS',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'INSURANCE SCHEME',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('scroll horizontally for details'),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topRight,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    height: 250.0,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      //scrollDirection: Axis.vertical,
                                      children: <Widget>[
                                        DataTable(
                                          columns: [
                                            DataColumn(
                                                label: Text('Scheme Name',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            DataColumn(
                                                label: Text('Member \nNumber',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            DataColumn(
                                                label: Text('Actions',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                          rows: [
                                            DataRow(cells: [
                                              DataCell(
                                                  Text('NHIF Civil Servant')),
                                              DataCell(Text('9783843189972')),
                                              DataCell(
                                                RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Profile()));
                                                  },
                                                  color: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .redAccent)),
                                                  elevation: 10.0,
                                                  textColor: Colors.white,
                                                  child: Text('Delete'),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(Text('JUBILEE')),
                                              DataCell(Text('23456786752')),
                                              DataCell(
                                                RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Profile()));
                                                  },
                                                  color: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .redAccent)),
                                                  elevation: 10.0,
                                                  textColor: Colors.white,
                                                  child: Text('Delete'),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(Text('ARMCO')),
                                              DataCell(Text('2367876543')),
                                              DataCell(
                                                RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Profile()));
                                                  },
                                                  color: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .redAccent)),
                                                  elevation: 10.0,
                                                  textColor: Colors.white,
                                                  child: Text('Delete'),
                                                ),
                                              ),
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                  Text('PRIVATE INSURANCE')),
                                              DataCell(Text('8765456789')),
                                              DataCell(
                                                RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Profile()));
                                                  },
                                                  color: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .redAccent)),
                                                  elevation: 10.0,
                                                  textColor: Colors.white,
                                                  child: Text('Delete'),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ],
                                    ),
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

Future<bool> Logout(BuildContext context) {
  return showDialog(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AlertDialog(
            title: Text('Logout from Medyq Patient.'),
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

Future getProfile(String phoneNumber, password) async {
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/login';
  Response response = await post(url, headers: {
    HttpHeaders.authorizationHeader:
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZW1vLm1lZHlxLXRlc3QubWhlYWx0aGtlbnlhLmNvLmtlXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjExNjQ2NDY1LCJleHAiOjE2MTE2NTAwNjUsIm5iZiI6MTYxMTY0NjQ2NSwianRpIjoiT0ZodUtzRVNBYVNDYWtnQiIsInN1YiI6MiwicHJ2IjoiYTY4MTVlNzk2OWM5MDhkMGIzNWMxOWIzMTI4ODkwNDkxNWRjY2ExMSJ9.09PVAfAts6Mn46asbctjPY78gqgLT3pI28cf8-E-rf8"
  }, body: {
    "phone_number": '0789000000',
    "password": '0789000000'
  });
  Map data = jsonDecode(response.body);
  print(response);
  print('object');
  print(data);

  /*token = data['token'];
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
}
