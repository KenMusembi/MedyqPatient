import 'dart:convert';
import 'dart:io';
//import 'dart:html' as html;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:medyq_patient/Widget/bezierContainer.dart';
import 'package:medyq_patient/screens/authenticate/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String token, facilitySchema, facilityName, facilityNumber, facilityCreatedAt;
  String phoneNumber, password;
  Map name;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String _valueF;

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

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.grey[200],
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.green[400], Colors.green[500]])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () {
        //print(phoneNumber);
        getData();
      },
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 3,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 3,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.white10, Colors.white12])),
      child: Text(
        'Register',
        style: TextStyle(fontSize: 20, color: Colors.green),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(text: '',
          /* style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),*/
          children: [
            TextSpan(
              text: '',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Medyq Patient',
              style: TextStyle(color: Colors.green[500], fontSize: 30),
            ),
          ]),
    );
  }

  Widget _forgotPassword() {
    return Visibility(
      visible: viewVisible,
      child: Column(
        children: [
          TextField(
            controller: emailController,
            autofocus: false,
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: 'Enter your email to reset account.'),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(2, 4),
                        blurRadius: 10,
                        spreadRadius: 2)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.white10, Colors.white24])),
              child: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            onTap: () {
              //print(phoneNumber);
              resetPassword();
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () {
                hideWidget();
              },
              child: Text('Close',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          // _entryField("Phone Number"),
          // _entryField("Password", isPassword: true),
          TextField(
            controller: phoneController,
            autofocus: false,
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: 'Enter your Phone Number'),
          ),
          SizedBox(
            height: 15,
          ),
          //Text('data', ),
          TextField(
            obscureText: true,
            controller: passwordController,
            autofocus: false,
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: 'Enter your password'),
          ),
        ],
      ),
    );
  }

  bool viewVisible = false;
  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        showWidget();
                      },
                      child: Text('Reset Password ?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  _forgotPassword(),
                  // _divider(),
                  //_facebookButton(),
                  SizedBox(height: height * .055),
                  //_createAccountLabel(),
                ],
              ),
            ),
          ),
          //Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }

  Future resetPassword() async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/reset-password-request';
    Response response = await post(url, headers: {
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZWR5cS10ZXN0Lm1oZWFsdGhrZW55YS5jby5rZVwvYXBpXC9sb2dpbiIsImlhdCI6MTYxMTU1NTA1NSwiZXhwIjoxNjExNTU4NjU1LCJuYmYiOjE2MTE1NTUwNTUsImp0aSI6IlY0eEpqa1RvdWE1YkJjVWUiLCJzdWIiOjIsInBydiI6ImE2ODE1ZTc5NjljOTA4ZDBiMzVjMTliMzEyODg5MDQ5MTVkY2NhMTEifQ.230hLOfYE7PwQnLcc7iaOwmOaVVfJQcfoUUPzW8PrNE"
    }, body: {
      "email": emailController.text
    });

    Map data = jsonDecode(response.body);
    print(response.body);
    print('object');

    if (data['message'] == 'Email does not exist.') {
      return Fluttertoast.showToast(
          msg: "This email does not exist.\n Please Try Again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (response.statusCode == 200 &&
        data['message'] ==
            'Check your inbox, we have sent a link to reset email.') {
      return Fluttertoast.showToast(
          msg: "Check your inbox, we have sent a link to reset your email.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print(response.body);
    }
  }

  Future getData() async {
    var url = 'http://medyq-test.mhealthkenya.co.ke/api/login';
    Response response = await post(url, headers: {
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZWR5cS10ZXN0Lm1oZWFsdGhrZW55YS5jby5rZVwvYXBpXC9sb2dpbiIsImlhdCI6MTYxMTU1NTA1NSwiZXhwIjoxNjExNTU4NjU1LCJuYmYiOjE2MTE1NTUwNTUsImp0aSI6IlY0eEpqa1RvdWE1YkJjVWUiLCJzdWIiOjIsInBydiI6ImE2ODE1ZTc5NjljOTA4ZDBiMzVjMTliMzEyODg5MDQ5MTVkY2NhMTEifQ.230hLOfYE7PwQnLcc7iaOwmOaVVfJQcfoUUPzW8PrNE"
    }, body: {
      "phone_number":
          phoneController.text.toString().trimRight(), //replaceAll(' ', ''),
      "password": passwordController.text.toString().trimRight()
    });
    print(phoneController.text + passwordController.text);
    Map data = jsonDecode(response.body);
    print(response);
    print('object');
    print(data);
    if (response.statusCode == 200 &&
        data['facility_visits'] == 'No facility visits') {
      token = data['token'];
      // facilitySchema = data['facility_visits'][0];

      return Fluttertoast.showToast(
          msg: "You are not attached to any facility.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (phoneController.text == '' || passwordController.text == '') {
      return Fluttertoast.showToast(
          msg:
              "One of the fields is empty. \n Please make sure you have entered your details.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (response.statusCode == 200 && data['facility_visits'] != null) {
      token = data['token'];
      facilitySchema = data['facility_visits'][0];
      facilityName = data['facility_visits'][1]['name'];
      facilityNumber = data['facility_visits'][1]['number'];
      facilityCreatedAt = data['facility_visits'][1]['creadted_at'];
      print(facilityName + '\n' + facilityNumber);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Profile(facilitySchema: facilitySchema, token: token)));
    } else {
      return Fluttertoast.showToast(
          msg: "Invalid Credentials. \n Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
