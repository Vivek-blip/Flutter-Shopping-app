import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class base2 {

  baser() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'seconddatabase.db'),

      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE secondlist(l_ist TEXT,t_itle TEXT,p_cs TEXT,w_eight TEXT,n_ote TEXT,b_oool TEXT)"
        );
      },
      version: 2,
    );
    print("Database created");
    return database;
  }


  Future<void> insertdata(Reciever1 reciever) async {
    final Database db = await baser();

    await db.insert(
        'secondlist',
        reciever.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore
    );
    return null;

  }

  Future<List<Reciever1>> lists(String cond) async {
    final Database db = await baser();
    final List<Map<String, dynamic>> maps = await db.query("secondlist",
        columns: ["l_ist", "t_itle", "p_cs", "w_eight","n_ote","b_oool"],
        where: 'l_ist = ?',
        whereArgs: [cond]);
    return List.generate(maps.length, (i) {
      return Reciever1(mainlist: maps[i]['l_ist'],
      title: maps[i]['t_itle'],
      pcs: maps[i]['p_cs'],
      weight: maps[i]['w_eight'],
      note: maps[i]['n_ote'],
      boool: maps[i]['b_oool']);
    });
  }

  Future<List<int>> Boolchecker(String lis) async {
    final Database db = await baser();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT COUNT(t_itle) AS "total" FROM secondlist WHERE b_oool="0" and l_ist="$lis"');
    return List.generate(maps.length, (i) {
      return maps[i]['total'];
    });
  }

  Future<void> deletedata(String del)async{
    final Database db=await baser();
    await db.delete("secondlist",where: 'l_ist=?',whereArgs: [del]);
  }

  Future<void> seconddeletedata(String mel,String lis)async{
    final Database db=await baser();
    await db.rawDelete('DELETE FROM secondlist WHERE t_itle="$mel" and l_ist="$lis" ');
  }
  Future<void> tickupdate(Reciever1 upd,String arg)async{
    final Database db=await baser();
    String a=upd.gettitle;
    String b=upd.getMAINLIST;
    await db.rawUpdate('UPDATE secondlist SET b_oool="$arg" WHERE t_itle="$a" AND l_ist="$b"');
  }

  Future<void> Editdata2(String strr,String newname)async{
    final Database db=await baser();

    await db.rawUpdate('UPDATE secondlist SET l_ist="$newname" WHERE l_ist="$strr"');
  }

}




class Reciever1{
  final String mainlist;
  final String title;
  final String pcs;
  final String weight;
  final String note;
  final String boool;

  Reciever1({this.mainlist,this.title,this.pcs,this.weight,this.note,this.boool});

  String get getMAINLIST=>mainlist;
  String get gettitle=>title;
  String get getpcs=>pcs;
  String get getweight=>weight;
  String get getnote=>note;
  String get getboool=>boool;

  Map<String,dynamic> toMap(){
    return{
      'l_ist':mainlist,
      't_itle':title,
      'p_cs':pcs,
      'w_eight':weight,
      'n_ote':note,
      'b_oool':boool,
    };
  }

  String toString(){
    return 'mainlist{l_ist:$mainlist}';
  }


}

