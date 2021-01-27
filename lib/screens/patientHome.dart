import 'package:flutter/material.dart';
import 'package:medyq_patient/Widget/bezierContainer.dart';
import 'package:medyq_patient/screens/appointments.dart';
import 'package:medyq_patient/screens/appointmentsDetails.dart';
import 'package:medyq_patient/screens/lab.dart';
import 'package:medyq_patient/screens/dependants.dart';
import 'package:medyq_patient/screens/radiology.dart';

import 'authenticate/profile.dart';

class PatientHome extends StatefulWidget {
  //

  final String title, facilityName, token;

  @override
  PatientHome({Key key, this.title, this.facilityName, this.token})
      : super(key: key);
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
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
    String facilityName = widget.facilityName;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      //color: Colors.grey,
      height: height,
      child: Stack(
        children: <Widget>[
          // Positioned(top: 40, left: 0, child: _backButton()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _backButton(),
                Text('Home', style: TextStyle(fontSize: 18)),
                //  SizedBox(width: 10),
                IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    })
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            right: 10,
            child: Column(
              children: [
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
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 25,
                        child: Text('Appointments in $facilityName' ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 10.0,
                  child: InkWell(
                    focusColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 25,
                        child: Text('Dependants'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
