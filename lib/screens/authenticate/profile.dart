import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medyq_patient/screens/About.dart';
import 'package:medyq_patient/screens/dependants.dart';
import 'package:medyq_patient/screens/models/allergiesClass.dart';
import 'package:medyq_patient/screens/models/dependantsClass.dart';
import 'package:medyq_patient/screens/models/nextOfKinClass.dart';
import 'package:medyq_patient/screens/models/schemesClass.dart';
import 'package:medyq_patient/screens/patientHome.dart';
import 'package:medyq_patient/screens/resources.dart';
import '../appointments.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  final String token, title;
  Profile({Key key, this.title, this.token}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int currentTab = 1;
  List<TabData> tabs = [
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.book, title: "About"),
    TabData(iconData: Icons.exit_to_app, title: "Logout")
  ];
  Future<List<AllergiesClass>> _allergies;
  Future<List<NextofKinClass>> _nextofkin;
  Future<List<DependantsClass>> _dependants;
  Future<List<SchemesClass>> _schemes;
  @override
  void initState() {
    //  String facility = widget.facilitySchema;
    String token = widget.token;
    //String patientID = widget.patientID;
    super.initState();
    //_allergies = _getAllergies(token, facility, patientID, context);
    //_nextofkin = _getNextofKin(token, facility, patientID, context);
    //_dependants = _getDependants(token, facility, patientID, context);
    //_schemes = _getSchemes(token, facility, patientID, context);
  }

  @override
  Widget build(BuildContext context) {
    // String facility = widget.facilitySchema;
    String token = widget.token;
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Appointments(token: token)));
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
        title: Text('Patient Details'),
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
      body: ListView(
        //color: Colors.grey,
        //height: height,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 5, 5),
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  // side: BorderSide(color: Colors.green, width: 0),
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.green,
              child: Container(
                  /*decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.green[300], Colors.green[300]]),
                  ),*/
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.green.shade200,
                          minRadius: 35.0,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9jdG9yJTIwYWZyaWNhbiUyMGFtZXJpY2FufGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                        ),
                        Icon(
                          Icons.settings,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text('Kennedy Musembi Munyao',
                        style: TextStyle(color: Colors.white)),
                    Text('+253748050434',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 5, 5),
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Appointments',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Appointments(token: token)));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.local_hospital,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Health Information.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      Logout(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.mood_bad,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Allergies',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      Logout(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.person_add,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Next of Kin',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      Logout(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dependants',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      Logout(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.schedule,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Insurance Schemes',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      Logout(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.green,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      Logout(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Resources()));
                break;
              case 2:
                Logout(context);

                break;
              default:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
            }
          });
        },
      ),
    );
  }

  Future<List<AllergiesClass>> _getAllergies(
      token, facility, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/allergies/316';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": facility});
    List<dynamic> data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);

    int usersPhoneNumber = data[0]['allergy_id'];
    print(usersPhoneNumber.toString());

    return List<AllergiesClass>.from(
        json.decode(response.body).map((x) => AllergiesClass.fromJson(x)));
  }

  Future<List<NextofKinClass>> _getNextofKin(
      token, facility, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/next-of-kin/1001';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": facility});
    List<dynamic> data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);

    int usersPhoneNumber = data[0]['allergy_id'];
    print(usersPhoneNumber.toString());

    return List<NextofKinClass>.from(
        json.decode(response.body).map((x) => NextofKinClass.fromJson(x)));
  }

  Future<List<DependantsClass>> _getDependants(
      token, facility, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/dependants/316';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": facility});
    List<dynamic> data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);

    int usersPhoneNumber = data[0]['allergy_id'];
    print(usersPhoneNumber.toString());

    return List<DependantsClass>.from(
        json.decode(response.body).map((x) => DependantsClass.fromJson(x)));
  }

  Future<List<SchemesClass>> _getSchemes(
      token, facility, patientID, context) async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/schemes/1';
    Response response = await post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {"facility": facility});
    List<dynamic> data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);

    int usersPhoneNumber = data[0]['allergy_id'];
    print(usersPhoneNumber.toString());

    return List<SchemesClass>.from(
        json.decode(response.body).map((x) => SchemesClass.fromJson(x)));
  }
}

/*
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
/*
Future getProfile(token) async {
  var url = 'http://medyq-test.mhealthkenya.co.ke/api/user';
  //var token;
  Response response = await get(
    url,
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  Map data = jsonDecode(response.body);
  print(response);
  print('object');
  print(data);

  String usersPhoneNumber = data['user']['phone_number'];
  print(usersPhoneNumber.toString());

  return (usersPhoneNumber.toString());
  /*
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
}*/
