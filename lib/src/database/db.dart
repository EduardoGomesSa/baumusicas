import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

abstract class Db {
  static Future<Database> connection() async{
    WidgetsFlutterBinding.ensureInitialized();

    final database = await openDatabase(
      join(await getDatabasesPath(), 'baumusicas_database.db'),

      onCreate: (db, version) {
        return db.execute('CREATE TABLE playlists(id INTEGER PRIMARY KEY, name TEXT)');
      },

      version: 1,
    );

    Future<Database> futureDatabase = Future.value(database);

    return futureDatabase;
  }
}