import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqltest/data/SQLs.dart';

class ConfigBD {
  // Cria ou abre o banco de dados
  static initBd() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dados.db');
    return await openDatabase(path, version: 1, onOpen: (db) {
      print('Okay');
    }, onCreate: (Database db, int version) async {
      // Se estiver criando, executa as querys
      await db.execute(personTable);
    });
  }
}
