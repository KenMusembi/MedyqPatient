import 'package:flutter/material.dart';

import 'appointments.dart';
import 'authenticate/login.dart';

class Dependants extends StatefulWidget {
  Dependants({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DependantsState createState() => _DependantsState();
}

class _DependantsState extends State<Dependants> {
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
                    Text('Dependants Profile',
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
                      Text('Dependant Name Here'),
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
                                        Text('Abdominal actinomycosis'),
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
                                        Text('Kennedy Musembi'),
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
