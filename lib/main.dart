import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppinglist/SecondPage.dart';
import 'package:shoppinglist/Util/Datadumper.dart';
import 'package:shoppinglist/Util/ListDialogue.dart';
import 'package:shoppinglist/Util/mainDatabase.dart';
import 'package:shoppinglist/Util/secondDatabase.dart';

void main()async => runApp(MaterialApp(
  home: MainHome(),
));

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<String> _notes;
  bool com=true;

  List<List<String>> rem=[];
  var database=base1();
  var database2=base2();


  relay()async {
    _notes = await database.lists();
    return _notes;
  }

  RecordsLeft(int index)async{
    return await database2.Boolchecker(_notes[index]);
  }


  Delete(String arg)async{
    setState(() async{
      await deleter().maindeleter(arg);
      _notes = await database.lists();
      print(_notes.length);
    });
  }

  Deletedialg(String strr,List<String>nts){
    showDialog(context: context,
      barrierDismissible: true,
      builder: (BuildContext context) =>
          Dialog(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 120,
              width: 120,
              child:Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text("Select",style: TextStyle(fontSize: 25,color:Colors.white70,fontFamily: "CustomFont2"),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FlatButton(
                              color: Colors.red,
                              onPressed: (){
                                setState(() {
                                  Delete(strr);
                                  Navigator.pop(context);
                                });
                              },
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Text("Delete",style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                            FlatButton(
                              color: Colors.blue,
                              onPressed: (){
                                setState(() {
                                  if(com==true){
                                    Navigator.pop(context);
                                    showDialog(context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) => ListeditDialg(nts,strr),);
                                  }
                                });
                              },
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Text("Edit",style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),
          ),);
  }

  @override
  Widget build(BuildContext context) {
    relay();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xff1B2631),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff283747),
          title: Center(
              child:Text("DigiList",style: TextStyle(fontSize: 34,color: Colors.white,fontFamily:'CustomFont',letterSpacing: 3,),))
      ),
      body: Center(
        child: Container(
          width: 350,
          child: FutureBuilder(
            future: relay(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data==null ||_notes.length==0){
                return Center(
                  child: Container(
                    child: Text("Lists you add appears here",style:TextStyle(fontSize: 15,color: Colors.white,fontFamily: "CustomFont2")),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Dismissible(key: Key(_notes[index]),
                      direction: DismissDirection.startToEnd,
                      confirmDismiss:   (DismissDirection direction) async {
                        bool res=true;
                        Scaffold.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1500),
                          content: Row(
                            children: <Widget>[
                              Icon(Icons.delete),
                              Text("Item Deleted"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                                child: Container(
                                  height: 33,
                                  child: IconButton(
                                    icon: Icon(Icons.undo,color: Colors.blue[400],),
                                    onPressed: (){
                                      res=false;
                                    },
//                                    child: Text("Undo",style: TextStyle(fontSize: 15,color: Colors.blue[400]),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                        com=false;
                        await Future.delayed(Duration(milliseconds: 1500));
                        com=true;
                        return res;
                      },
                      onDismissed: (direction){
                      setState(() {
                        Delete(_notes[index]);
                      });
                      },
                      background: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        color: Colors.red[400],child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.delete),
                        ],
                      ),),
                      child: Container(
                          height: 105,
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color: Color(0x34495E),
                            child: Center(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                              Container(
                                width: 236,
                                child: Text(_notes[index],style: TextStyle(
                                    color: Colors.white,fontWeight:FontWeight.bold,fontSize: 22,fontFamily:'CustomFont2'),),
                              ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 55, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text("Left : ",style: TextStyle(
                                              color: Colors.white,fontWeight:FontWeight.bold,fontSize: 15,fontFamily:'CustomFont2')),
                                          Container(
                                            height: 20,
                                            width: 22,
                                            child: FutureBuilder(
                                              future: RecordsLeft(index),
                                              builder: (BuildContext context,AsyncSnapshot shot){
                                                if(shot.data==null ||shot.data.length==0){
                                                  return Container(
                                                    child: Icon(Icons.refresh,color: Colors.white,)
                                                  );
                                                }
                                                return Text(shot.data[0].toString(),style: TextStyle(
                                                    color: Colors.blue[400],fontWeight:FontWeight.bold,fontSize: 18,fontFamily:'CustomFont2'),);
                                              }
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>Home(snapshot.data[index])));
                                },
                                onLongPress: (){
                                  Deletedialg(snapshot.data[index],_notes);
                                },
                              ),
                            ),
                          )
                      ),
                    );}
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(com==true){
            showDialog(context: context,
              barrierDismissible: true,
              builder: (BuildContext context) => ListDialg(_notes),);
          }

        },
        child: Icon(Icons.add),
      ),
    );
  }

}
