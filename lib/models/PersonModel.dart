import 'dart:convert';

class Person {
  int id;
  String firstName;
  String lastName;

  Person({this.id, this.firstName, this.lastName});

  factory Person.fromMap(Map<String, dynamic> json) => new Person(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name']);

  Map<String, dynamic> toMap() =>
      {"id": id, "first_name": firstName, "last_name": lastName};
}

// Instancia um objeto Person de um JSON
Person personFromJson(String str) {
  final jsonData = json.decode(str);
  return personFromJson(jsonData);
}

// Converte um objeto Person em JSON
String personToJson(Person person) {
  final dyn = person.toMap();
  return json.encode(dyn);
}
