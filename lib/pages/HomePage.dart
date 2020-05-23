import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqltest/models/PersonModel.dart';
import 'package:sqltest/pages/Person/Create.dart';
import 'package:sqltest/pages/Person/Edit.dart';
import 'package:sqltest/services/PersonService.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var personSelected = new Person();

  // Método que chama a página de criar Person
  void callCreatePageRoute(String title) {
    var rotaCriarPerson = MaterialPageRoute(
        builder: (context) => CreatePersonPage(
              title: "Create Person",
            ));
    Navigator.push(context, rotaCriarPerson);
  }

  // Método que chama a página de editar Person
  void callEditPageRoute(String title, int personId) async {
    var person = await PersonService.getById(personId);
    var rotaEditarPerson = MaterialPageRoute(
        builder: (context) => EditPersonPage(
              title: "Edit Person",
              person: person,
            ));
    Navigator.push(context, rotaEditarPerson);
  }

  // Método que chama uma AlertDialiog para excluir pessoa
  void callDialogDeletePerson(int personId) {
    _showCustomDialog(personId);
  }

  // Método que exclui pessoa e atualiza
  void deletePerson(int personId) {
    var resultado = PersonService.delete(personId);
    setState(() {
      if (resultado != null) print("Delete confirmed!");
    });
  }

  // Método que chama uma AlertDialiog
  void _showCustomDialog(int personId) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Person!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This action will delete a Person register'),
                  Text('Are you sure?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes, that's fine!"),
                onPressed: () {
                  deletePerson(personId);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("No, cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Person>>(
        future: PersonService.getAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Person person = snapshot.data[index];
                return Card(
                  child: Slidable(
                    actionPane: SlidableScrollActionPane(),
                    actionExtentRatio: 0.25,
                    child: ListTile(
                      title: Text(person.firstName),
                      subtitle: Text(person.lastName),
                      leading: Icon(Icons.person),
                    ),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.blue,
                        icon: Icons.edit,
                        onTap: () {
                          callEditPageRoute("Edit Person", person.id);
                        },
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          callDialogDeletePerson(person.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callCreatePageRoute("Create Person");
        },
        tooltip: 'Criar',
        child: Icon(Icons.add),
      ),
    );
  }
}
