import 'package:flutter/material.dart';
import 'package:medyq_patient/Widget/bezierContainer.dart';
import 'package:medyq_patient/screens/appointmentsDetails.dart';

import 'authenticate/profile.dart';
import 'bookAppointment.dart';

class Appointments extends StatefulWidget {
  Appointments({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
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
        body: Container(
      //color: Colors.grey,
      height: height,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _backButton(),
                Text('Appointments',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
            top: 60,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Text('Kennedy Musembi'),
                Text('+254748050434'),
                SizedBox(height: 10.0),
                Text(
                  'Upcoming Appointments',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
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
                                SizedBox(height: 10.0),
                                Row(children: [
                                  Text('12/01/2021'),
                                  SizedBox(width: 10.0),
                                  Text('Demartology Clinic'),
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  Text('Time:'),
                                  SizedBox(width: 10.0),
                                  Text('11:30 - 12:00'),
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  Text('Description:'),
                                  SizedBox(width: 10.0),
                                  Text('Appointment test by Ken.'),
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Past Appointments',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text('click to see details.'),
                SizedBox(height: 10),
                Card(
                  color: Colors.white,
                  elevation: 10.0,
                  child: InkWell(
                    focusColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentsDetails()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: 50,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(children: [
                                  Text('12/01/2021'),
                                  SizedBox(width: 10.0),
                                  Text('Optical Clinic'),
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
          /*   Positioned(
            //top: 20,
            right: 20,
            bottom: 40,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookAppointments()));
              },
              color: Colors.green,
              elevation: 10.0,
              textColor: Colors.white,
              child: Text('Book Appointment'),
            ),
          ),*/
        ],
      ),
    ));
  }
}
