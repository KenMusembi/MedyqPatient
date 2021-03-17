import 'package:flutter/material.dart';
import 'package:medyq_patient/screens/authenticate/profile.dart';
import 'package:medyq_patient/screens/facebookWidget.dart';
import 'package:medyq_patient/screens/resources.dart';
import 'authenticate/login.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class About extends StatefulWidget {
  final String facilitySchema, token, title;
  About({Key key, this.title, this.facilitySchema, this.token})
      : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  int currentTab = 2;
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
    return Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/logo.png'),
            SizedBox(height: 20),
            Text(
              'Version',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            Text(
              '1.0.1 Beta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10),
            Text(
              'Build',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            Text(
              '4',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10),
            Text(
              'Last Update',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            Text(
              'March 2021',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            Text(
              'MedyQ is a patient facing app for the MedyQ system used in health facilities countrywide.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 3,
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
