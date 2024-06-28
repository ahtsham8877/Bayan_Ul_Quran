// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:io';
import 'package:bayanulquran/Model/BookMarksModel.dart';
import 'package:bayanulquran/Model/FolderModel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_archive/flutter_archive.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, "bayanulquran.db");

    bool fileExists = await File(dbPath).exists();

    if (!fileExists) {
      ByteData data = await rootBundle.load('assets/database/bayanulquran.zip');
      List<int> bytes = data.buffer.asUint8List();

      String zipPath = join(documentsDirectory.path, 'bayanulquran.zip');
      await File(zipPath).writeAsBytes(bytes);

      File zipFile = File(zipPath);
      Directory destinationDir = Directory(documentsDirectory.path);
      await ZipFile.extractToDirectory(
        zipFile: zipFile,
        destinationDir: destinationDir,
      );

      if (await zipFile.exists()) {
        await zipFile.delete().catchError((e) {
          print("Error deleting zip file: $e");
        });
      }

      dbPath = join(documentsDirectory.path, "bayanulquran.db");
    }

    // Open the database
    Database database =
        await openDatabase(dbPath, version: 2, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE folders (id INTEGER PRIMARY KEY, name TEXT, created_date TEXT)');
      await db.execute(
          'CREATE TABLE bookmarks (id INTEGER PRIMARY KEY, surahID INTEGER, title TEXT, content TEXT, mainContent TEXT, timestamp TEXT, folder_id INTEGER, FOREIGN KEY(folder_id) REFERENCES folders(id))');
    });

    return database;
  }

  Future<void> insertBookmark(Bookmark bookmark) async {
    final dbClient = await db;
    try {
      await dbClient.insert(
        'bookmarks',
        bookmark.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Bookmark added");
    } catch (e) {
      print("Error inserting bookmark: $e");
    }
  }

  Future<List<Bookmark>> getBookmarks() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('bookmarks');
    return List.generate(maps.length, (i) {
      return Bookmark.fromMap(maps[i]);
    });
  }

  Future<void> deleteBookmark(int id) async {
    final dbClient = await db;
    await dbClient.delete(
      'bookmarks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertFolder(Folder folder) async {
    final dbClient = await db;
    try {
      await dbClient.insert(
        'folders',
        folder.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Folder added");
    } catch (e) {
      print("Error inserting folder: $e");
    }
  }

  Future<List<Folder>> getFolders() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('folders');
    return List.generate(maps.length, (i) {
      return Folder.fromMap(maps[i]);
    });
  }

  Future<void> deleteFolder(int id) async {
    final dbClient = await db;
    await dbClient.delete(
      'folders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> executeQuery(String query) async {
    final dbClient = await db;
    return await dbClient.rawQuery(query);
  }

  Future<List<Map<String, dynamic>>> addTableName(String tableName) async {
    final dbClient = await db;
    return await dbClient.query(tableName);
  }
}
