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
  Map name;
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

//import 'package:connectivity/connectivity.dart';
  var subscription;
  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
    });
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
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
          TextField(
            keyboardType: TextInputType.number,
            controller: phoneController,
            autofocus: false,
            decoration: new InputDecoration(
                labelText: 'Phone Number',
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
              labelText: 'Password',
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
          /*  TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
                labelText: 'Password',
                icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.lock))),
            validator: (val) => val.length < 6 ? 'Password too short.' : null,
            onSaved: (val) => password = val,
            obscureText: _obscureText,
          ),
          new FlatButton(
              onPressed: _toggle,
              child: new Text(_obscureText ? "Show" : "Hide")),
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
          ),*/
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
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

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
        var url = 'http://medyq-test.mhealthkenya.co.ke/api/login';
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

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile(
                        //facilitySchema: facilitySchema,
                        token: token,
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
            data['facility_visits'] != null) {
          token = data['token'];
          facilitySchema = data['facility_visits'][0];
          String patientID =
              data['facility_visits'][1]['patient_id'].toString();
          //facilityNumber = data['facility_visits'][1]['number'];
          //facilityCreatedAt = data['facility_visits'][1]['creadted_at'];
          print(patientID);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile(
                        // facilitySchema: facilitySchema,
                        token: token,
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
          msg: "Check your connection and try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber[500],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
