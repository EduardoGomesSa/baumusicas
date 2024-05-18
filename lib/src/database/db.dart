import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

import 'dart:async';

abstract class Db {
  static Future<sql.Database> connection() async{
    WidgetsFlutterBinding.ensureInitialized();
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'baumusicas_database.db'),

      onCreate: (db, version) {
        return db.execute('CREATE TABLE playlists(id INTEGER PRIMARY KEY, name TEXT)');
      },

      version: 1,
    );
  }
}