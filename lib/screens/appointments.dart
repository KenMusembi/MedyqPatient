import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/appointmentsDetails.dart';
import 'package:medyq_patient/screens/resources.dart';
import 'about.dart';
import 'appointmentsClass.dart';
import 'authenticate/login.dart';
import 'authenticate/profile.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

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
  int currentTab = 1;
  List<TabData> tabs = [
    TabData(iconData: Icons.home, title: "Profile"),
    TabData(iconData: Icons.calendar_today, title: "Appointments"),
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.info, title: "About")
  ];
  Future<List<AppointmentsClass>> _appointments;
  @override
  void initState() {
    super.initState();
    String facility = widget.facility;
    String token = widget.token;
    _appointments = getAppointments(facility, token, context);
  }

  @override
  Widget build(BuildContext context) {
    String facility = widget.facility;
    String token = widget.token;

    ListTile _title(String title, String subtitle) =>
        ListTile(title: Text(title), subtitle: Text(subtitle));
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
                Navigator.pop(context);
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
              leading: Icon(Icons.question_answer),
              title: Text('Appointments'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
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
        title: Text('Appointments'),
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
      body: Center(
        //color: Colors.grey,
        //height: height,

        child: Column(
          children: [
            Flexible(
              //flex: 2,
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

                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                color: Colors.grey[200],
                                child: Column(
                                  children: [
                                    ListTile(
                                        enabled: true,
                                        // isThreeLine: true,

                                        hoverColor: Colors.green,
                                        autofocus: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(5, 10, 5, 0),
                                        //  isThreeLine: true,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AppointmentsDetails(
                                                          facility: facility,
                                                          token: token)));
                                        },
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              yourPosts[index].name.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Icon(
                                              Icons.calendar_today,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                        subtitle: //Text('13/02/2021' + '\t \t' + '11:00 AM'),
                                            Text('Date:\t' +
                                                yourPosts[index]
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
                                                '\t' +
                                                '\t' +
                                                yourPosts[index]
                                                    .startTime
                                                    .toString()
                                                    .replaceRange(5, 8, '') +
                                                ' - ' +
                                                yourPosts[index]
                                                    .endTime
                                                    .toString()
                                                    .replaceRange(5, 8, ''))),
                                    /* subtitle: Text(yourPosts[index]
                                          .description
                                          .toString()),
                                      trailing: Text('Time:\t' +
                                          yourPosts[index]
                                              .startTime
                                              .toString()
                                              .replaceRange(5, 8, '') +
                                          ' - ' +
                                          yourPosts[index]
                                              .endTime
                                              .toString()
                                              .replaceRange(5, 8, '')),*/

                                    // ),
                                    Divider(
                                      height: 2,
                                      thickness: 2,
                                      color: Colors.grey[200],
                                    ),
                                  ],
                                ),
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

//if(facility == 'None'){}
  Future<List<AppointmentsClass>> getAppointments(
      facility, token, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/appointments/0093';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": 'demo_2019_08_23_181408'});
    //Map<String, dynamic> data = jsonDecode(response.body);
    print(response.body);

    return List<AppointmentsClass>.from(
        json.decode(response.body).map((x) => AppointmentsClass.fromJson(x)));
  }
}
