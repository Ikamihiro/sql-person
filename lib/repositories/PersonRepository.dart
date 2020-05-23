import 'package:sqflite/sqflite.dart';
import 'package:sqltest/data/ConfigBD.dart';
import 'package:sqltest/models/PersonModel.dart';

class PersonRepository {
  // Construtor privado
  PersonRepository._();
  // Expõe o construtor para fora
  static final PersonRepository bd = PersonRepository._();
  static Database _database;

  // Get Database
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await ConfigBD.initBd();
    return _database;
  }

  // Insere Person no bd
  newPerson(Person person) async {
    final db = await database;
    var resultado = db.insert("person", person.toMap());
    return resultado;
  }

  // Puxa um Person do bd
  Future<Person> getPerson(int id) async {
    final db = await database;
    var resultado = await db.query("person", where: "id = ?", whereArgs: [id]);
    return resultado.isNotEmpty ? Person.fromMap(resultado.first) : Null;
  }

  // Puxa todos os registros
  Future<List<Person>> getPeople() async {
    final db = await database;
    var resultado = await db.query("person");
    List<Person> people = resultado.isNotEmpty
        ? resultado.map((i) => Person.fromMap(i)).toList()
        : [];
    return people;
  }

  // Atualiza um determinado registro
  updatePerson(Person person) async {
    final db = await database;
    var resultado = await db.update("person", person.toMap(),
        where: "id = ?", whereArgs: [person.id]);
    return resultado;
  }

  // Elemina um determinado registro
  deletePerson(int id) async {
    final db = await database;
    db.delete("person", where: "id = ?", whereArgs: [id]);
  }
}
