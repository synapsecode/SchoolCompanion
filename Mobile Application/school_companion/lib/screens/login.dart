import 'package:flutter/material.dart';
import '../components/login/subcomponents.dart';
import 'package:school_companion/datastore.dart' as datastore;

class LoginComponent extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String _hostServer;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                      title: new Text("Initialization"),
                      content: Container(
                        height: 130.0,
                        width: MediaQuery.of(context).size.width,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Server URL:'),
                                validator: (input) => input.length == 0
                                    ? 'Host Server Cannot Be Empty'
                                    : null,
                                onSaved: (input) => _hostServer = input,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton(
                                      color: Colors.blue.shade700,
                                      child: Text("Initialize Server"),
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          formKey.currentState.save();
                                          datastore.initServer(_hostServer);
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
          },
          child: PresidencyLogo(),
        ),
        TitleText(),
        SizedBox(height: 20.0),
        UsernameandPasswordForm()
      ],
    );
  }
}
