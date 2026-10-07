import '../models/user_model.dart';
import 'db_helper.dart';

class UserManager {
  static final UserManager shared = UserManager._internal();
  UserManager._internal();

  // REGISTER
  Future<bool> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final db = await DBHelper.instance.database;

    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existing.isNotEmpty) return false;

    await db.insert('users', {
      'username': username,
      'email': email,
      'password': password,
    });

    return true;
  }

  // LOGIN
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final db = await DBHelper.instance.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isEmpty) return null;

    final favs = await db.query(
      'favourites',
      where: 'email = ?',
      whereArgs: [email],
    );

    return UserModel(
      username: result.first['username'] as String,
      email: result.first['email'] as String,
      password: result.first['password'] as String,
      favouriteIDs:
      favs.map((e) => e['id'] as String).toList(),
      favouriteNames:
      favs.map((e) => e['name'] as String).toList(),
      favouriteImages:
      favs.map((e) => e['image'] as String).toList(),
    );
  }

  // ADD FAVOURITE
  Future<void> addFavourite({
    required String email,
    required String id,
    required String name,
    required String image,
  }) async {
    final db = await DBHelper.instance.database;

    await db.insert('favourites', {
      'id': id,
      'email': email,
      'name': name,
      'image': image,
    });
  }

  // REMOVE FAVOURITE
  Future<void> removeFavourite({
    required String email,
    required String id,
  }) async {
    final db = await DBHelper.instance.database;

    await db.delete(
      'favourites',
      where: 'id = ? AND email = ?',
      whereArgs: [id, email],
    );
  }

  // GET USER WITH FAVS
  Future<UserModel?> getUserByCredentials({
    required String email,
    required String password,
  }) async {
    return loginUser(email: email, password: password);
  }

  // UPDATE PASSWORD
  Future<void> updatePassword({
    required String email,
    required String password,
    required String newPassword,
  }) async {
    final db = await DBHelper.instance.database;

    await db.update(
      'users',
      {'password': newPassword},
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
  }
}



Future<void> printDatabaseData() async {
  final db = await DBHelper.instance.database;

  final users = await db.query('users');
  final favs = await db.query('favourites');

  print("===== USERS TABLE =====");
  for (var u in users) {
    print(u);
  }

  print("===== FAVOURITES TABLE =====");
  for (var f in favs) {
    print(f);
  }
}