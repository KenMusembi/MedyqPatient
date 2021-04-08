import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/models/appointmentsClass.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenPage createState() => _HomeScreenPage();
}

class _HomeScreenPage extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<List<AppointmentsClass>> _appointments;
  TabController tabController;

  String title = "Home";

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    String facility = 'demo_2019_08_23_181408';
    String token =
        "weyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZW1vLm1lZHlxLXRlc3QubWhlYWx0aGtlbnlhLmNvLmtlXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjE1NTQzNTk4LCJleHAiOjE2MTU1NDcxOTgsIm5iZiI6MTYxNTU0MzU5OCwianRpIjoiZ1daNEg2YVZ3M1VqRXd2cSIsInN1YiI6MSwicHJ2IjoiYTY4MTVlNzk2OWM5MDhkMGIzNWMxOWIzMTI4ODkwNDkxNWRjY2ExMSJ9.G0fleZML1oCR3GDsaGOJxgXi51EzoZaZIb94E7T1sfM";
    _appointments = getAppointments(facility, token, context);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.purple,
            brightness: Brightness.light,
            accentColor: Colors.red),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: new Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
          ),
          body: TabBarView(
            children: <Widget>[
              FirstTab(),
              MyBody("Page Two"),
              MyBody("Page Three")
            ],
// if you want yo disable swiping in tab the use below code
//            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
          ),
        ));
  }
}

class FirstTab extends StatefulWidget {
  @override
  FirstTabState createState() => FirstTabState();
}

class FirstTabState extends State<FirstTab>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var timy = DateTime.now();
    // TODO: implement build
    String facility = 'demo_2019_08_23_181408';
    String token =
        "weyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZW1vLm1lZHlxLXRlc3QubWhlYWx0aGtlbnlhLmNvLmtlXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjE1NTQzNTk4LCJleHAiOjE2MTU1NDcxOTgsIm5iZiI6MTYxNTU0MzU5OCwianRpIjoiZ1daNEg2YVZ3M1VqRXd2cSIsInN1YiI6MSwicHJ2IjoiYTY4MTVlNzk2OWM5MDhkMGIzNWMxOWIzMTI4ODkwNDkxNWRjY2ExMSJ9.G0fleZML1oCR3GDsaGOJxgXi51EzoZaZIb94E7T1sfM";
    // _appointments = getAppointments(facility, token, context);
    var _appointments = getAppointments(facility, token, context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 50.0,
            child: new TabBar(
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blue,
              tabs: [
                Tab(
                  text: "Previous",
                ),
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Upcoming",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Flexible(
              //flex: 2,
              child: new FutureBuilder<List<AppointmentsClass>>(
                  future: _appointments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<AppointmentsClass> yourPosts = snapshot.data
                          .where((i) => i.createdAt.isBefore(timy))
                          .toList();
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
                                                      HomeScreen()));
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No Pending Appointments'),
            ),
            Flexible(
              //flex: 2,
              child: new FutureBuilder<List<AppointmentsClass>>(
                  future: _appointments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<AppointmentsClass> yourPosts = snapshot.data
                          .where((i) => i.createdAt.isAfter(timy))
                          .toList();
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
                                                      HomeScreen()));
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
    );
  }
}

class MyBody extends StatelessWidget {
  final String title;

  MyBody(this.title);

  final mySnackBar = SnackBar(
    content: Text(
      "Hello There!",
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              child: Text(title + "  Click me"),
              onPressed: () => {Scaffold.of(context).showSnackBar(mySnackBar)}),
        ],
      ),
    );
  }
}

Future<List<AppointmentsClass>> getAppointments(
    facility, token, context) async {
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/appointments/0093';
  Response response = await post(url, headers: {
    HttpHeaders.authorizationHeader:
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZW1vLm1lZHlxLXRlc3QubWhlYWx0aGtlbnlhLmNvLmtlXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjE1ODkwOTQ1LCJleHAiOjE2MTU4OTQ1NDUsIm5iZiI6MTYxNTg5MDk0NSwianRpIjoiYm84MnFJcXkzOFFZOUlydSIsInN1YiI6MSwicHJ2IjoiYTY4MTVlNzk2OWM5MDhkMGIzNWMxOWIzMTI4ODkwNDkxNWRjY2ExMSJ9.9rD3AFhtnZuuVpZr3VHfCmHpel5sgKrMYEYxvunQU0g"
  }, body: {
    "facility": 'demo_2019_08_23_181408'
  });
  //Map<String, dynamic> data = jsonDecode(response.body);
  print(response.body);

  return List<AppointmentsClass>.from(
      json.decode(response.body).map((x) => AppointmentsClass.fromJson(x)));
}
