import 'package:flutter/material.dart';
import 'package:medyq_patient/screens/authenticate/profile.dart';
import 'package:medyq_patient/screens/resources.dart';

import 'appointments.dart';
import 'authenticate/login.dart';

class About extends StatefulWidget {
  final String facilitySchema, token, title;
  About({Key key, this.title, this.facilitySchema, this.token})
      : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    String facility = widget.facilitySchema;
    String token = widget.token;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('Resources'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChooseLocation()));
                },
              ),
              /* ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('FAQs'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Appointments()));
                },
              ),*/
              ListTile(
                leading: Icon(Icons.collections_bookmark),
                title: Text('About App'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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
          title: Text('About App'),
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/logo.png'),
              SizedBox(height: 20),
              Text(
                'Version',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              Text(
                '1.0.0 Beta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Text(
                'Build',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              Text(
                '9',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Text(
                'Last Update',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              Text(
                'February 2021',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30),
              Text(
                'MedyQ is a patient facing app for the MedyQ system used in health facilities countrywide.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              )
            ],
          ),
        ));
  }
}

Future<bool> Logout(BuildContext context) {
  return showDialog(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: AlertDialog(
            title: Text('Logout from Medyq.'),
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
