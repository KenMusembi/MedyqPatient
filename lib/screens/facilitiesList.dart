import 'package:flutter/material.dart';
import 'package:medyq_patient/Widget/bezierContainer.dart';
import 'package:medyq_patient/screens/authenticate/profile.dart';

import 'patientHome.dart';

class FacilitiesList extends StatefulWidget {
  FacilitiesList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FacilitiesListState createState() => _FacilitiesListState();
}

class _FacilitiesListState extends State<FacilitiesList> {
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
    final width = MediaQuery.of(context).size.width;
    final width2 = width / 2 - 40;
    return Scaffold(
        body: Container(
      //color: Colors.grey,
      height: height,
      width: width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _backButton(),
                    Text('Health Facilities',
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
                        })
                  ],
                ),
                SizedBox(height: 10.0),
                Column(
                  children: [
                    Text('Please click a facility below to see your records.'),
                    SizedBox(height: 20.0),
                    Container(
                      //  width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        builder: (context) => Profile()));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 30, 0, 12),
                                child: Container(
                                  width: width2,
                                  height: 80,
                                  child: Text('Kenyatta National Hospital '),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 30, 0, 12),
                                child: Container(
                                  width: width2,
                                  height: 80,
                                  child: Text('Nairobi Womens Hospital'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
