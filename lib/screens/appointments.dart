import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/appointmentsDetails.dart';
import 'appointmentsClass.dart';
import 'authenticate/profile.dart';

void main() {
  runApp(Appointments());
}

class Appointments extends StatefulWidget {
  Appointments({Key key, this.title, this.facility, this.token})
      : super(key: key);

  final String title, facility, token;

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  Future<List<AppointmentsClass>> _appointments;
  @override
  void initState() {
    super.initState();
    String facility = widget.facility;
    String token = widget.token;
    _appointments = getAppointments(facility, token, context);
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

  @override
  Widget build(BuildContext context) {
    String facility = widget.facility;
    String token = widget.token;

    ListTile _title(String title, String subtitle) =>
        ListTile(title: Text(title), subtitle: Text(subtitle));
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
      //color: Colors.grey,
      //height: height,

      child: Column(
        children: [
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
          SizedBox(height: 10),
          Flexible(
            child: new FutureBuilder<List<AppointmentsClass>>(
                future: _appointments,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<AppointmentsClass> yourPosts = snapshot.data;
                    return new ListView.builder(
                        itemCount: yourPosts.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Whatever sort of things you want to build
                          // with your Post object at yourPosts[index]:

                          return Card(
                            child: Column(
                              children: [
                                ListTile(
                                  enabled: true,
                                  //  isThreeLine: true,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentsDetails(
                                                    facility: '$facility',
                                                    token: '$token')));
                                  },

                                  title: Text(yourPosts[index]
                                          .createdAt
                                          .month
                                          .toString() +
                                      '-' +
                                      yourPosts[index]
                                          .createdAt
                                          .day
                                          .toString() +
                                      '-' +
                                      yourPosts[index]
                                          .createdAt
                                          .year
                                          .toString() +
                                      '\n' +
                                      yourPosts[index].name.toString()),
                                  subtitle: Text(
                                      yourPosts[index].description.toString()),
                                  trailing: Text(
                                      yourPosts[index].startTime.toString() +
                                          ' - ' +
                                          yourPosts[index].endTime.toString()),
                                ),

                                // ),
                              ],
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
        ],
      ),
    ));
  }
/*
  void viewAppointments(index, yourPosts) async {
    //imageCache.clear();

    AppointmentsClass instance = yourPosts[index];

    // navigate to home screen and pass any data as well, eg location, flag
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              AppointmentsDetails(facility: '$facility', token: token)),
      // );
    );
  }*/

  Future<List<AppointmentsClass>> getAppointments(
      facility, token, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/appointments/1003';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": '$facility'});
    //Map<String, dynamic> data = jsonDecode(response.body);
    print(response.body);
    return List<AppointmentsClass>.from(
        json.decode(response.body).map((x) => AppointmentsClass.fromJson(x)));
  }
}
