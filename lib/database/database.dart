import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';
import '../models/contact_model.dart';

class DatabaseHelper {
  
  static final DatabaseHelper _instance = DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  late Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();
    return _database;
  }

  DatabaseHelper._();

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT,
            userId INTEGER,
            FOREIGN KEY(userId) REFERENCES users(id)
          )
        ''');
      },
    );
  }

  // Métodos para manipular a tabela de usuários

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(
      maps.length,
      (index) => UserModel(
        id: maps[index]['id'],
        email: maps[index]['email'],
        password: maps[index]['password'], 
      ),
    );
  }

  // Métodos para manipular a tabela de contatos

  Future<int> insertContact(ContactModel contact) async {
    final db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(
      maps.length,
      (index) => ContactModel(
        id: maps[index]['id'],
        name: maps[index]['name'],
        phone: maps[index]['phone'],
      ),
    );
  }

  Future<int> updateContact(ContactModel contact) async {
    Database db = await database;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
