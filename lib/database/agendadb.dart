import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:practica_1/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AgendaDB {
  static const nameDB = 'Agenda';
  static int versionDB = 1;
  static Database? _database;

  Future<Database?> get getDatabase async {
    if( _database != null ) return _database!;
    return _database = await _initDatabase();
  }
  
  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables
    );
  }
  
  FutureOr<void> _createTables (Database db, int version) {
      String query = '''create table tblName(
                          idTask integer primary key,
                          nameTask varchar(50),
                          dscTask varchar(50),
                          sttTask byte
                        );''';
      db.execute(query);
    }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var connection = await getDatabase;
    return connection!.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var connection = await getDatabase;
    return connection!.update(tblName, data, 
                              where: 'idTask = ?', 
                              whereArgs: [data['idTask']]);
  }

  Future<int> DELETE(String tblName, int idTask) async {
    var connection = await getDatabase;
    return connection!.delete(tblName, 
                              where: 'idTask = ?', 
                              whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALLTASK() async{
    var connection = await getDatabase;
    var result = await connection!.query('tblName');
    return result.map((task)=>TaskModel.fromMap(task)).toList();
  }  
}