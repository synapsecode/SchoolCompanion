import 'package:flutter/material.dart';
import 'package:school_companion/screens/Homepage/homepage.dart';
import '../../datastore.dart' as datastore;
import 'package:school_companion/datastore.dart' as datastore;

class PresidencyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      width: 200.0,
      child: Image.asset('assets/logo.png', fit: BoxFit.contain),
    );
  }
}

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'School Companion',
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }
}

class UsernameandPasswordForm extends StatefulWidget {
  @override
  _UsernameandPasswordFormState createState() =>
      _UsernameandPasswordFormState();
}

class _UsernameandPasswordFormState extends State<UsernameandPasswordForm> {
  final formKey = GlobalKey<FormState>();
  String _username, _password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270.0,
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Username:'),
              validator: (input) =>
                  input.length == 0 ? 'Username Cannot Be Empty' : null,
              onSaved: (input) => _username = input,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password:'),
              validator: (input) =>
                  input.length == 0 ? 'Password Cannot be Empty' : null,
              onSaved: (input) => _password = input,
              obscureText: true,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 115.0),
              color: Color.fromARGB(80, 22, 46, 77),
              child: Text("Login"),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  void handlelogin(Map<String, dynamic> responseBody) {
    try {
      if (responseBody['response']['CODE'] == "OK") {
        Map<String, dynamic> body = responseBody['response']['INFO'];
        datastore.assignUserInfo(body);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    Home(datastore.getUserInfo())));
        // String studentName = body['student_name'];
        // String grade = double.parse(body['grade']).round().toString();
        // String rollNo = double.parse(body['roll_no']).round().toString();
        // String section = body['section'];
        // String phone = body['phone'];
        // String email = body['email'];
        // String country = body['country'];
        // String state = body['state'];
        // String city = body['city'];
        // String address = body['address'];
        // showDialog(
        //     context: context,
        //     builder: (_) => new AlertDialog(
        //           title: new Text("Login Successful!"),
        //           content: Container(
        //             height: 250.0,
        //             child: Column(
        //               children: <Widget>[
        //                 Text("Name: $studentName"),
        //                 Text("Email: $email"),
        //                 Text("Grade: $grade"),
        //                 Text("Section: $section"),
        //                 Text("Roll Number: $rollNo"),
        //                 Text("Phone Number: $phone"),
        //                 Text("Country: $country"),
        //                 Text("State: $state"),
        //                 Text("City: $city"),
        //                 Text("Address: $address"),
        //               ],
        //             ),
        //           ),
        //         ));

      } else if (responseBody['response']['CODE'] == "INCORRECT CREDENTIALS") {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Incorrect Credentials"),
                  content: Container(
                      height: 40.0,
                      child: Center(
                        child:
                            Text("Either Your Username or Password is Wrong"),
                      )),
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Unexpected Error Occured"),
                content: Container(
                    height: 40.0,
                    child: Center(
                      child: Text("Please wait until Issue has been fixed."),
                    )),
              ));
    }
  }

  void _submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Map<String, dynamic> responseBody =
            await datastore.requestLogin(_username, _password);
        handlelogin(responseBody);
      } catch (e) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Cannot Connect to Server"),
                  content: Container(
                      height: 120.0,
                      child: Center(
                        child: Text(
                            "The Login Process was aborted as the Client cannot communicate with the host server. Please try again later or wait until the issue has been officially fixed."),
                      )),
                ));
      }
    }
  }
}
