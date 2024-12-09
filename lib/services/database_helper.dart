import 'package:demo/models/login_model.dart';
import 'package:demo/utils/Const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // Don't forget to import this for `join()` method

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(Const.USER_DATA);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      // Create table with all necessary columns
      await db.execute('''
        CREATE TABLE "${Const.USER_INFO}" (
          id INTEGER PRIMARY KEY,
          success INTEGER,
          mobile_no TEXT,
          role_id TEXT,
          user_id INTEGER,
          token TEXT,
          fcm_key TEXT,
          profile_status TEXT,
          partner_document TEXT,
          vehicle_document TEXT,
          category_status TEXT,
          approve_status TEXT,
          message TEXT
        )
      ''');
    });
  }

  // Save the entire SignInResponse object
  Future<void> saveUserData(SignInResponse response) async {
    final db = await database;
    await db.insert('user', {
      'success': response.success == true ? 1 : 0,
      'mobile_no': response.data?.mobileNo,
      'role_id': response.data?.roleId,
      'user_id': response.data?.id,
      'token': response.data?.token,
      'fcm_key': response.data?.fcmKey,
      'profile_status': response.data?.profileStatus,
      'partner_document': response.data?.partnerDocument,
      'vehicle_document': response.data?.vehicleDocument,
      'category_status': response.data?.categoryStatus,
      'approve_status': response.data?.approveStatus,
      'message': response.message,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch user data from the database
  Future<SignInResponse?> getUserData() async {
    final db = await database;
    final result = await db.query('user', limit: 1);

    if (result.isEmpty) {
      return null;
    } else {
      // Map the result into SignInResponse object
      final data = result.first;
      final userData = Data(
        mobileNo: data['mobile_no'].toString(),
        roleId: data['role_id'].toString(),
        id: data['user_id']!= null ? data['user_id'] as int : null,
        token: data['token'].toString(),
        fcmKey: data['fcm_key'].toString(),
        profileStatus: data['profile_status'].toString(),
        partnerDocument: data['partner_document'].toString(),
        vehicleDocument: data['vehicle_document'].toString(),
        categoryStatus: data['category_status'].toString(),
        approveStatus: data['approve_status'].toString(),
      );

      return SignInResponse(
        success: data['success'] == 1, // Convert int to bool
        data: userData,
        message: data['message'].toString(),
      );
    }
  }

  // Delete user data from the database
  Future<void> deleteUser() async {
    final db = await database;
    await db.delete('user');
  }
}
