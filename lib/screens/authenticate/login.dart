import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:medyq_patient/Widget/bezierContainer.dart';
import 'package:medyq_patient/screens/authenticate/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String token, facilitySchema, facilityName, facilityNumber, facilityCreatedAt;
  String phoneNumber, password;
  //Map name;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool viewVisible = false;
  bool _obscureText = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

//below method shows password
  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

//below method hides password
  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

//check if the phone has intenet connection, whether wifi or mobile data
  var subscription;
  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {});
  }

//dispose the subscription on state change, to be redone everytime the page is reloaded
  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

//widget for the submit button
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
        getData();
      },
    );
  }

//widget for title, highly customizable
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
              text: 'MedyQ Patient',
              style: TextStyle(color: Colors.green[500], fontSize: 30),
            ),
          ]),
    );
  }

//widget for forgot password, also highly customizable
  Widget _forgotPassword() {
    return Visibility(
      visible: viewVisible,
      child: Column(
        children: [
          TextField(
            controller: emailController,
            autofocus: false,
            decoration: new InputDecoration(
                labelText: 'Email Address',
                suffixText: '*',
                suffixStyle: TextStyle(color: Colors.red, fontSize: 18),
                icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.email)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
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
                      colors: [Colors.grey[300], Colors.grey[300]])),
              child: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            onTap: () {
              resetPassword();
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerRight,
            child: TextButton(
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

  //widget for emailpassword, with input and function for reseting account
  Widget _emailPasswordWidget() {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            controller: phoneController,
            autofocus: false,
            decoration: new InputDecoration(
                labelText: 'Phone Number (10 digits)',
                suffixText: '*',
                suffixStyle: TextStyle(color: Colors.red, fontSize: 18),
                icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.phone)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                ),
                hintText: 'Enter your phone number'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: passwordController,
            obscureText: !_obscureText, //This will obscure text dynamically
            decoration: InputDecoration(
              labelText: 'Password (at least 6 characters)',
              suffixText: '*',
              suffixStyle: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.green, width: 1.0),
              ),
              icon: const Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: const Icon(Icons.lock)),
              hintText: 'Enter your password',
              // Here is key idea
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
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
              //bezier container is the green animation above the login screen
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
                    child: TextButton(
                      onPressed: () {
                        showWidget();
                      },
                      child: Text('Reset Password ?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  _forgotPassword(),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  //initialize connectivityResult to checkConnectivity function
  var connectivityResult = (Connectivity().checkConnectivity());

  Future resetPassword() async {
    if (ConnectivityResult.none == true) {
      return Fluttertoast.showToast(
          msg:
              "You are not connected to the internet.\n Check your connection and try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (emailController.text == null || emailController.text == '') {
      return Fluttertoast.showToast(
          msg: "Please Enter an email.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber[500],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var url =
          'http://medyq-test.mhealthkenya.co.ke/api/reset-password-request';
      Response response = await post(url, headers: {
        HttpHeaders.authorizationHeader:
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZWR5cS10ZXN0Lm1oZWFsdGhrZW55YS5jby5rZVwvYXBpXC9sb2dpbiIsImlhdCI6MTYxMTU1NTA1NSwiZXhwIjoxNjExNTU4NjU1LCJuYmYiOjE2MTE1NTUwNTUsImp0aSI6IlY0eEpqa1RvdWE1YkJjVWUiLCJzdWIiOjIsInBydiI6ImE2ODE1ZTc5NjljOTA4ZDBiMzVjMTliMzEyODg5MDQ5MTVkY2NhMTEifQ.230hLOfYE7PwQnLcc7iaOwmOaVVfJQcfoUUPzW8PrNE"
      }, body: {
        "email": emailController.text.toString().trim()
      });

      Map data = jsonDecode(response.body);
      print(response.body);
      print('object');

      if (emailController.text.contains('@') == false) {
        return Fluttertoast.showToast(
            msg: "This is not a valid email. \n Check and try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.amber[500],
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (data['message'] == 'Email does not exist.') {
        return Fluttertoast.showToast(
            msg: "This email does not exist.\n Please Try Again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.amber[500],
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
        return Fluttertoast.showToast(
            msg: "Error. Kindly check your network and try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.amber[500],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future getData() async {
    try {
      if (ConnectivityResult.none == true) {
        return Fluttertoast.showToast(
            msg:
                "You are not connected to the internet.\n Check your connection and try again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        var url = 'http://demo.medyq-test.mhealthkenya.co.ke/api/login';
        Response response = await post(url, headers: {
          HttpHeaders.authorizationHeader:
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZWR5cS10ZXN0Lm1oZWFsdGhrZW55YS5jby5rZVwvYXBpXC9sb2dpbiIsImlhdCI6MTYxMTU1NTA1NSwiZXhwIjoxNjExNTU4NjU1LCJuYmYiOjE2MTE1NTUwNTUsImp0aSI6IlY0eEpqa1RvdWE1YkJjVWUiLCJzdWIiOjIsInBydiI6ImE2ODE1ZTc5NjljOTA4ZDBiMzVjMTliMzEyODg5MDQ5MTVkY2NhMTEifQ.230hLOfYE7PwQnLcc7iaOwmOaVVfJQcfoUUPzW8PrNE"
        }, body: {
          "phone_number": phoneController.text
              .toString()
              .trimRight(), //replaceAll(' ', ''),
          "password": passwordController.text.toString().trimRight()
        });
        print(phoneController.text + passwordController.text);
        Map data = jsonDecode(response.body);
        print(response);
        print('object');
        print(data);
        if (phoneController.text.toString().length != 10) {
          return Fluttertoast.showToast(
              msg: "Phone number must be exactly 10 digits. \n e.g 0722098098",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER_RIGHT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.amber[500],
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (passwordController.text.toString().length < 6) {
          return Fluttertoast.showToast(
              msg:
                  "Password must be at least 6 characters. \n Kindly try again.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER_RIGHT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.amber[500],
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (response.statusCode == 200 &&
            data['facility_visits'] == 'No facility visits') {
          token = data['token'];
          String patientID =
              data['facility_visits'][0]['patient_id'].toString();
          print('patient id is ' + patientID);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile(
                        facility: facilitySchema,
                        token: token,
                        patientID: patientID,
                      )));
        } else if (phoneController.text == '' ||
            passwordController.text == '') {
          return Fluttertoast.showToast(
              msg:
                  "One of the fields is empty. \n Please make sure you have entered your details.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER_RIGHT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.amber[500],
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (response.statusCode == 200 &&
            data['facility_visits'] != "No facility visits") {
          token = data['token'];
          facilitySchema = data['facility_visits'][0];
          String patientID =
              data['facility_visits'][1]['patient_id'].toString();
          print('patient id is' + patientID);
          print(data);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile(
                        facility: facilitySchema,
                        token: token,
                        patientID: patientID,
                      )));
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
    } on Exception catch (e) {
      return Fluttertoast.showToast(
          msg: "Server Downtime, Kindly retry later.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber[500],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
