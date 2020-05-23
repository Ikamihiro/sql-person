import 'package:flutter/material.dart';
import 'package:sqltest/models/PersonModel.dart';
import 'package:sqltest/services/PersonService.dart';

class EditPersonPage extends StatefulWidget {
  EditPersonPage({Key key, this.title, this.person}) : super(key: key);
  final String title;
  final Person person;

  @override
  _EditPersonState createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPersonPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerFirstName;
  TextEditingController _controllerLastName;

  @override
  void initState() {
    super.initState();
    getPerson();
  }

  void getPerson() async {
    _controllerFirstName = TextEditingController(text: widget.person.firstName);
    print(_controllerFirstName.text);
    _controllerLastName = TextEditingController(text: widget.person.lastName);
    print(_controllerLastName.text);
  }

  void editPerson(Person personEdit) {
    widget.person.firstName = personEdit.firstName;
    widget.person.lastName = personEdit.lastName;
    PersonService.update(widget.person);
    Navigator.pop(context);
  }

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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                    Person person = new Person(
                        firstName: _controllerFirstName.text,
                        lastName: _controllerLastName.text);
                    editPerson(person);
                  }
                },
                child: Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
