import 'package:sqltest/models/PersonModel.dart';
import 'package:sqltest/repositories/PersonRepository.dart';

class PersonService {
  static Future<List<Person>> getAll() {
    return PersonRepository.bd.getPeople();
  }

  static Future<Person> getById(int id) {
    return PersonRepository.bd.getPerson(id);
  }

  static insert(Person person) {
    return PersonRepository.bd.newPerson(person);
  }

  static update(Person person) {
    return PersonRepository.bd.updatePerson(person);
  }

  static delete(int id) {
    return PersonRepository.bd.deletePerson(id);
  }
}
