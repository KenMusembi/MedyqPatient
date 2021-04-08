import 'package:flutter/material.dart';
import 'package:medyq_patient/screens/authenticate/profile.dart';
import 'package:medyq_patient/Widget/facebookWidget.dart';
import 'package:medyq_patient/screens/resources.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'About.dart';
import 'appointments.dart';
import 'authenticate/login.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class ResourcesDetail extends StatefulWidget {
  var url;

  var datePosted;

  var picture;

  var description;

  var heading;

  ResourcesDetail(
      {Key key,
      this.url,
      this.picture,
      this.heading,
      this.description,
      this.datePosted})
      : super(key: key);
  @override
  _ResourcesDetailState createState() => _ResourcesDetailState();
}

class _ResourcesDetailState extends State<ResourcesDetail> {
  int currentTab = 1;
  List<TabData> tabs = [
    TabData(iconData: Icons.home, title: "Profile"),
    TabData(iconData: Icons.calendar_today, title: "Appointments"),
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.info, title: "About")
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    String picture = widget.picture;
    String heading = widget.heading;
    String description = widget.description;
    String datePosted = widget.datePosted;

    //set background
    String bgImage = '$picture' != null ? '$picture' : 'jitenge.png';
    // Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: Drawer(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset('assets/logo.png'),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.file_copy_rounded,
                color: Colors.green,
              ),
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
              leading: Icon(
                Icons.book,
                color: Colors.green,
              ),
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
              leading: Icon(
                Icons.info,
                color: Colors.green,
              ),
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
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.green,
              ),
              title: Text('Logout'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Logout(context);
              },
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter, child: SocialButtons()))
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text(' $heading'),
        centerTitle: true,
        elevation: 3,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () => _logout(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              //color: Colors.white60,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .35,
              child: Image.network(
                '$picture',
                width: 800,
                height: 200,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  borderOnForeground: true,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Material(
                        elevation: 24.0,
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                              child: Column(
                                children: [
                                  Text(
                                    '\n' + '$heading' + '\n',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      // letterSpacing: 1.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text('Posted on: $datePosted' + '\n'),
                                ],
                              )),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  borderOnForeground: true,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Material(
                        elevation: 24.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Post',
                                  style: TextStyle(
                                    height: 2,
                                    fontSize: 18.0,
                                    //letterSpacing: 1.0,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '$description',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Additional files.',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    letterSpacing: 1.0,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RaisedButton(
                                    color: Colors.white,
                                    elevation: 5,
                                    onPressed: () {
                                      launch(url);
                                    },
                                    child: new Row(
                                      children: [
                                        Icon(
                                          Icons.file_download,
                                          color: Colors.blue,
                                          size: 18.0,
                                        ),
                                        Text(
                                          ' Download document from browser.',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ],
                                    )),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ]),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 2,
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
                Navigator.pop(context);
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
}

Future<bool> _logout(BuildContext context) {
  return showDialog(
        context: context,
        builder: (BuildContext context) {
          child:
          AlertDialog(
            title: Text('Logout from MedyQ?'),
            content: Text('Are you sure you want to log out?'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
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
          );
        },
      ) ??
      false;
}
