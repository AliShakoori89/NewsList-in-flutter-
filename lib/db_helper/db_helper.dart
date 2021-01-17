import 'package:news_with_bloc/models/news_response.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB_Helper {

  static final String ColID = 'ID';
  static final String ColTitle = 'Title';
  static final String ColFull = 'FullPost';
  static final String ColImage = 'Image';
  static final String ColDate = 'Date';
  static final String ColCat = 'Cat';
  static final String DB_Name = 'News.db';
  static final String Table_Name = 'NewsTable';

  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async{
    var dbpath = await getDatabasesPath();
    var path = join(dbpath , DB_Name);
    var ourdb = await openDatabase(path, version: 1 , onCreate: _oncreate);
    return ourdb;
  }

  _oncreate(Database db , int version) async{
    await db.execute('CREATE TABLE $Table_Name($ColID INTEGER PRIMARY KEY , $ColTitle TEXT , $ColFull TEXT , $ColImage TEXT , $ColDate TEXT , $ColCat TEXT)');
    print('Table created ...');
  }

  Future<int> savePost(NewsDetailsModel modelpost) async{
    var mydb = await db;
    var status = mydb.insert('NewsTable', modelpost.toMap());
    print('Post Saved .......');
    return status;
  }

  Future<bool> CheckData(var id) async{
    var mydb = await db;
    var res = await mydb.rawQuery('SELECT * FROM $Table_Name WHERE $ColID = $id');
    if(res.length == 0) return false;
    else return true;
  }

  Future<int> DeletePost(var id) async{
    var mydb = await db;
    var res = await mydb.delete(Table_Name,where : '$ColID=?' , whereArgs: [id]);
    return res;
  }

  Future close() async{
    var mydb = await db;
    mydb.close();
  }
}