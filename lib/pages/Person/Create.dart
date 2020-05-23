import 'package:flutter/material.dart';
import 'package:sqltest/models/PersonModel.dart';
import 'package:sqltest/services/PersonService.dart';

class CreatePersonPage extends StatefulWidget {
  CreatePersonPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CreatePersonState createState() => _CreatePersonState();
}

class _CreatePersonState extends State<CreatePersonPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Person first name:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: _controllerFirstName,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field cannot be empty!';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Person last name:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: _controllerLastName,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Person person = Person(
                          firstName: _controllerFirstName.text,
                          lastName: _controllerLastName.text);
                      PersonService.insert(person);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          )),
    );
  }
}
