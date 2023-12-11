import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:practica_1/models/carrera_model.dart';
import 'package:practica_1/models/profe_model.dart';
import 'package:practica_1/models/tarea_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TareaProfesor {
  static const nameDB = 'TareasProfesor';
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
      String query = '''create table tblCarrera(
                        idCarrera integer primary key,
                        nomCarrera varchar(50)
                        );''';
      db.execute(query);
      query = ''' create table tblProfe(
                  idProfe integer primary key,
                  nomProfe varchar(50),
                  email varchar(50),
                  idCarrera integer,
                  foreign key(idCarrera) REFERENCES tblCarrera(idCarrera)
                  );''';
      db.execute(query);
      query = ''' create table tblTarea(
                  idTarea integer primary key,
                  nomTarea varchar(50),
                  fecExp DateTime,
                  fecRec DateTime,
                  desTarea varchar(50),
                  realizada integer,
                  idProfe integer,
                  foreign key(idProfe) REFERENCES tblProfe(idProfe)
                  );''';
      db.execute(query);
    }

  Future<int> insert(String tblName, Map<String, dynamic> data) async {
    var connection = await getDatabase;
    return connection!.insert(tblName, data);
  }

Future<int> update(String tblName, Map<String, dynamic> data, String whereKey) async {
    var connection = await getDatabase;
    return connection!.update(tblName, data, 
                              where: '$whereKey = ?', 
                              whereArgs: [data[whereKey]]);
  }

  Future<int> delete(String tblName, int id, String whereKey) async {
    var connection = await getDatabase;
    return connection!.delete(tblName, 
                              where: '$whereKey = ?', 
                              whereArgs: [id]);
  }

  Future<List<CarreraModel>> getCarreraData() async {
    var connection = await getDatabase;
    var result = await connection!.query('tblCarrera');
    return result.map((task) => CarreraModel.fromMap(task)).toList();
  }

  Future<List<ProfeModel>> getProfeData() async {
    var connection = await getDatabase;
    var result = await connection!.query('tblProfe');
    return result.map((task) => ProfeModel.fromMap(task)).toList();
  }

  Future<List<TareaModel>> getTareaData() async {
    var connection = await getDatabase;
    var result = await connection!.query('tblTarea');
    return result.map((task) => TareaModel.fromMap(task)).toList();
  }

  Future<List<TareaModel>> getTareaRealizada(int realizada) async {
    var connection = await getDatabase;
    var result = await connection!.query('tblTarea',
                                          where: 'realizada = ?',
                                          whereArgs: [realizada],
                                        );
    return result.map((task) => TareaModel.fromMap(task)).toList();
  }

  Future<List<TareaModel>> getTareaFecha(String fecha) async {
    var connection = await getDatabase;
    var result = await connection!.query('tblTarea',
                                          where: 'fecExp = ?',
                                          whereArgs: [fecha],
                                        );
    return result.map((task) => TareaModel.fromMap(task)).toList();
  }

  Future<bool> getForeignKey(String tblName, String colForKey, int valForKey) async {
    final connection = await getDatabase;
    final List<Map<String, dynamic>> result = await connection!.query(tblName, 
      where: '$colForKey = ?',
      whereArgs: [valForKey] 
    );
    return result.isEmpty;
  }
}