import 'package:flutter/material.dart';
import 'package:medyq_patient/screens/authenticate/login.dart';
import 'package:medyq_patient/screens/authenticate/profile.dart';
import 'package:medyq_patient/Widget/facebookWidget.dart';
import 'package:medyq_patient/screens/healthInfo.dart';
import 'About.dart';
import 'models/resource.dart';
import 'resources-detail.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class Resources extends StatefulWidget {
  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  int currentTab = 1;
  List<TabData> tabs = [
    TabData(iconData: Icons.home, title: "Profile"),
    TabData(iconData: Icons.calendar_today, title: "Appointments"),
    TabData(iconData: Icons.collections_bookmark, title: "Resources"),
    TabData(iconData: Icons.info, title: "About")
  ];
  List<Resource> resources = [
    Resource(
        picture:
            'https://images.unsplash.com/photo-1584744982493-704a9eea4322?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
        datePosted: 'June 12th 2020',
        url:
            'http://c4c-api.mhealthkenya.org/storage/uploads/1592985162HCWs%20risk%20assesment%20tool.docx',
        description: 'Healthcare workers risk assesment tool for COVID 19',
        heading: 'Healthcare workers risk assesment tool'),
    Resource(
        picture:
            'https://images.unsplash.com/photo-1579544757872-ce8f6af30e0f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
        datePosted: 'June 10th 2020',
        url:
            'http://c4c-api.mhealthkenya.org/storage/uploads/1591774086Case%20management%20protocol.pdf',
        description:
            'Covid 19 Infection Prevention and Control (IPC) and Case Managememnt from the Ministry of Health.' +
                '\n' +
                'These consolidated guidelines provide recomendation for comprehensive prevention and case management strategies in Kenya',
        heading:
            'Covid 19 Infection Prevention and Control (IPC) and Case Managememnt from the Ministry of Health.'),
    Resource(
        picture:
            'https://images.unsplash.com/photo-1584634731339-252c581abfc5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80',
        datePosted: 'June 10th 2020',
        url:
            'http://c4c-api.mhealthkenya.org/storage/uploads/1591773868Kenya%20IPC_Considerations_For%20Health%20Care%20Settings.docx',
        description:
            'Attached is a document containing the Ministry of Health Interim Infections Prevention amd Control Recomendations for Coronovirus Disease 2019 (COVID-19) in Health Care Settings.',
        heading: 'Kenya IPC Considerations For Health Care Settings.')
  ];

  void updateTime(index) async {
    imageCache.clear();
    Resource instance = resources[index];
    await instance.getResource();
    // navigate to home screen and pass any data as well, eg location, flag
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResourcesDetail(
                url: instance.url,
                description: instance.description,
                heading: instance.heading,
                picture: instance.picture,
                datePosted: instance.datePosted,
              )),
      // );
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Resources'),
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
      body: ListView.builder(
          itemCount: resources.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Card(
                  child: Column(
                    children: [
                      Material(
                          child: InkWell(
                        onTap: () {
                          updateTime(index);
                        },
                        child: Container(
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              '${resources[index].picture}',
                              height: 150,
                              width: 340,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )),

                      ListTile(
                        enabled: true,
                        //  isThreeLine: true,
                        onTap: () {
                          updateTime(index);
                        },

                        title: Text(resources[index].heading +
                            '  ' +
                            '\n' +
                            resources[index].datePosted),
                        subtitle: Text(resources[index].description),
                        //trailing: Text(resources[index].datePosted),
                      ),
                      SizedBox(
                        height: 20,
                      )
                      // ),
                      // Text(resources[index].heading)
                    ],
                  ),
                ));
          }),
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
