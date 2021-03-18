import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(SocialButtons());

Widget _facebookButton() {
  return Container(
      //width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
              icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue[900]),
              onPressed: () {
                launch('https://www.mhealthkenya.org/');
              }),
          IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
              icon: Icon(FontAwesomeIcons.twitter, color: Colors.blue),
              onPressed: () {
                launch('https://www.mhealthkenya.org/');
              }),
          IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
              icon: Icon(FontAwesomeIcons.linkedin, color: Colors.blue[600]),
              onPressed: () {
                launch('https://www.mhealthkenya.org/');
              }),
          IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
              icon: Icon(FontAwesomeIcons.inbox, color: Colors.indigo[600]),
              onPressed: () {
                launch('https://www.mhealthkenya.org/');
              }),
        ],
      ));
}

class SocialButtons extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //redirects to the warrper screen
      body: _facebookButton(),
    );
  }
}
