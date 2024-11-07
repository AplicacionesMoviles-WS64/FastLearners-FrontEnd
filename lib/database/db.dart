import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modelo/creditCard.dart';
import '../modelo/usuarios.dart';


class DB {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    print("Database path: $path");
    return openDatabase(
      join(path, 'dbUsuarios.db'),
      onCreate: (database, version) async {

        await database.execute(
          'CREATE TABLE usuarios(id INTEGER PRIMARY KEY, nombre TEXT, correo TEXT, password TEXT, plan TEXT)',
        );

        await database.execute(
          'CREATE TABLE credit_cards(id INTEGER PRIMARY KEY AUTOINCREMENT, cardNumber TEXT, cardHolderName TEXT, expirationDate TEXT, cvv TEXT, nickname TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(Usuario usu) async {
    try {
      final db = await initializeDB();
      await db.insert(
        'usuarios',
        usu.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error al insertar usuario: $e");
    }
  }
  Future<void> updateUserPlan(String email, String plan) async {
    final db = await initializeDB();
    await db.update(
      'usuarios',
      {'plan': plan},
      where: 'correo = ?',
      whereArgs: [email],
    );
  }

  Future<Usuario?> getUserByCredentials(String correo, String password) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> result = await db.query(
      'usuarios',
      where: 'correo = ? AND password = ?',
      whereArgs: [correo, password],
    );

    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    }
    return null;
  }

  Future<void> insertCreditCard(CreditCard card) async {
    try {
      final db = await initializeDB();
      await db.insert(
        'credit_cards',
        card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error al insertar tarjeta: $e");
    }
  }

  Future<List<CreditCard>> getAllCreditCards() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> result = await db.query('credit_cards');

    return result.map((map) => CreditCard.fromMap(map)).toList();
  }
}