import 'package:flutter/material.dart';
import 'package:medyq_patient/Widget/bezierContainer.dart';

import 'authenticate/profile.dart';
import 'bookAppointment.dart';

class AppointmentsDetails extends StatefulWidget {
  AppointmentsDetails({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppointmentsDetailsState createState() => _AppointmentsDetailsState();
}

class _AppointmentsDetailsState extends State<AppointmentsDetails> {
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
        body: ListView(
      //color: Colors.grey,
      // height: height,

      children: <Widget>[
        // Positioned(top: 40, left: 0, child: _backButton()),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _backButton(),
              Text('Past Appointments',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
          // left: 10,
          //  right: 10,
          child: Column(
            children: [
              Text('Kennedy Musembi'),
              Text('+254748050434'),
              SizedBox(height: 10.0),
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
                              Text('LAB RESULTS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                          Text(
                            'PRESCRIPTIONS',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text('scroll horizontally for details'),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20.0),
                            height: 250.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              //scrollDirection: Axis.vertical,
                              children: <Widget>[
                                DataTable(
                                  columns: [
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
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text('AMOXYCILLIN 500MG')),
                                      DataCell(Text('1')),
                                      DataCell(Text('1 mL')),
                                      DataCell(Text('1 * Daily')),
                                      DataCell(Text('2*1')),
                                      DataCell(Text('After Meals')),
                                      DataCell(Text('None')),
                                      DataCell(Text('Dispensed')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('AMOXYCILLIN 500MG')),
                                      DataCell(Text('2')),
                                      DataCell(Text('9 10^12/L')),
                                      DataCell(Text('1 * Daily')),
                                      DataCell(Text('1*3')),
                                      DataCell(Text('After Meals')),
                                      DataCell(Text('None')),
                                      DataCell(Text('Not Dispensed')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('AMOXYCILLIN 500MG')),
                                      DataCell(Text('2')),
                                      DataCell(Text('1 mg')),
                                      DataCell(Text('1 * Daily')),
                                      DataCell(Text('1*2')),
                                      DataCell(Text('Before Meals')),
                                      DataCell(Text('None')),
                                      DataCell(Text('Note Dispensed')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('AMOXYCILLIN 500MG')),
                                      DataCell(Text('9')),
                                      DataCell(Text('1 mL')),
                                      DataCell(Text('1 * Daily')),
                                      DataCell(Text('2*3')),
                                      DataCell(Text('Before Meals')),
                                      DataCell(Text('None')),
                                      DataCell(Text('Not Dispensed')),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentsDetails()));
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Row(children: [
                                Text(''),
                                SizedBox(width: 10.0),
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentsDetails()));
                                  },
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side:
                                          BorderSide(color: Colors.blueAccent)),
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
        /*   Positioned(
            //top: 20,
            right: 20,
            bottom: 40,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookAppointmentsDetails()));
              },
              color: Colors.green,
              elevation: 10.0,
              textColor: Colors.white,
              child: Text('Book Appointment'),
            ),
          ),*/
      ],
      //  ),
    ));
  }
}
