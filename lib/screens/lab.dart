import 'package:flutter/material.dart';
import 'package:medyq_patient/Widget/bezierContainer.dart';

class Lab extends StatefulWidget {
  Lab({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LabState createState() => _LabState();
}

class _LabState extends State<Lab> {
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
          Positioned(top: 40, left: 0, child: _backButton()),
          Positioned(
              top: 50,
              left: 120,
              child: Text('Lab', style: TextStyle(fontSize: 18))),
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
                  shadowColor: Colors.black,
                  child: InkWell(
                    focusColor: Colors.blue.withAlpha(30),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 300,
                        //height: 50,
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('12/01/2021'),
                                      SizedBox(width: 20.0),
                                      Text('NAIROBI LAB SERVICES'),
                                    ]),
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //SizedBox(width: 20.0),
                                      Text('Item: \t Blood Grouping'),
                                      //SizedBox(width: 20.0),
                                      Text('Quantity: \t 1.00'),
                                    ]),
                                /* Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        print('object');
                                      },
                                      color: Colors.blueAccent,
                                      elevation: 10.0,
                                      textColor: Colors.white,
                                      child: Text('Reschedule'),
                                    ),
                                    SizedBox(width: 20),
                                    RaisedButton(
                                      onPressed: () {
                                        print('object');
                                      },
                                      color: Colors.green,
                                      elevation: 10.0,
                                      textColor: Colors.white,
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                ),*/
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
          /* Positioned(
            //top: 20,
            right: 20,
            bottom: 40,
            child: RaisedButton(
              onPressed: () {
                print('object');
              },
              color: Colors.green,
              elevation: 10.0,
              textColor: Colors.white,
              child: Text('Refresh'),
            ),
          ),*/
        ],
      ),
    ));
  }
}
