import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class base1{

  baser()async{
    final database=openDatabase(
        join(await getDatabasesPath(),'maindatabase.db'),

        onCreate: (db,version){
    return db.execute(
    "CREATE TABLE mainlist(l_ist TEXT)"
    );
    },
    version: 1,
    );
    return database;

  }



  Future<void> insertdata(Reciever reciever)async{
    final Database db=await baser();

    await db.insert(
    'mainlist',
    reciever.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace
    );
    print(await lists());
  }

  Future<List<String>> lists()async{
    final Database db=await baser();
    final List<Map<String, dynamic>> maps = await db.query('mainlist');
    return List.generate(maps.length, (i){
      return maps[i]['l_ist'];
    });
  }

  Future<void> deletedata(String strr)async{
    final Database db=await baser();

    await db.delete("mainlist",where: 'l_ist=?',whereArgs: [strr]);
  }

  Future<void> Editdata1(String strr,String newname)async{
    final Database db=await baser();

    await db.rawUpdate('UPDATE mainlist SET l_ist="$newname" WHERE l_ist="$strr"');
  }

}




class Reciever{
  final String mainList;

  Reciever({this.mainList});

  Map<String,dynamic> toMap(){
    return{
      'l_ist':mainList
    };
  }

  String toString(){
    return 'mainlist{l_ist:$mainList}';
  }


}

