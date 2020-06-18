import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Util/DialogueBox.dart';
import 'package:flutter/services.dart';
import 'package:shoppinglist/Util/secondDatabase.dart';
import 'package:shoppinglist/Util/Datadumper.dart';
import 'package:shoppinglist/Util/Bottompopup.dart';
class Home extends StatefulWidget {
  String mainList;
  Home(this.mainList);
  @override
  _HomeState createState() => _HomeState(mainList);
}

class _HomeState extends State<Home>  {
  final GlobalKey key=GlobalKey();
  String mainList;
  IconData icn=Icons.do_not_disturb_on;
  MaterialColor clr=Colors.red;
  List<Reciever1> _notes;
  bool com=true;
  var database=base2();


  _HomeState(this.mainList);


  Refrsh(){
   setState(() {

   });
  }


  icon(Reciever1 Its){
    if (Its.getboool=="1"){
      return Icons.done;
    }
    else{
      return Icons.remove_circle_outline;
    }

  }

  color(Reciever1 clr) {
    if (clr.getboool=="1") {
      return Colors.green;
    }
    else {
      return Colors.red;
    }
  }

  color1(Reciever1 clr) {
    if (clr.getboool=="1") {
      return Colors.white30;
    }
    else {
      return Colors.white;
    }
  }
  color2(Reciever1 clr) {
    if (clr.getboool=="1") {
      return Colors.white30;
    }
    else {
      return Colors.blue[300];
    }
  }

  pcs1(String arg){
    if(arg==".."||arg==""){
      return " ";
    }
    else{
      return "Pcs ";
    }
  }
  pcs2(String arg){
    if(arg==".."||arg==""){
      return " ";
    }
    else{
      return arg;
    }
  }
  Weight1(String arg){
    if(arg=="..Kg"||arg=="..g"||arg=="g"||arg=="Kg"){
      return " ";
    }
    else{
      return "Weight ";
    }
  }
  Weight2(String arg){
    if(arg=="..Kg"||arg=="..g"||arg=="g"||arg=="Kg"){
      return " ";
    }
    else{
      return arg;
    }
  }
  divider(Reciever1 arg){
    if(arg.getweight=="..Kg"||arg.getweight=="..g"||arg.getpcs==".."||arg.getweight=="g"||arg.getweight=="Kg"||arg.getpcs==""){
      return Color(0x11fffff);
    }
    else{
      return Colors.white30;
    }

  }

  void Tick(Reciever1 Nts)async{
    if(Nts.getboool=="0"){
      await database.tickupdate(Reciever1(mainlist: Nts.getMAINLIST,title: Nts.gettitle,pcs: Nts.getpcs,weight: Nts.getweight,note: Nts.getnote,boool: "1"), "1");
    }
    else{
      await database.tickupdate(Reciever1(mainlist: Nts.getMAINLIST,title: Nts.gettitle,pcs: Nts.getpcs,weight: Nts.getweight,note: Nts.getnote,boool: "0"), "0");
    }
  }

  Segregator()async{
    _notes=await database.lists(mainList);
    return _notes;
  }


  @override                                               //Main Widget tree
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xff1B2631),
      appBar: AppBar(
        leading: MaterialButton(
          onPressed:(){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
          elevation: 0,
          backgroundColor: Color(0xff283747),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0,0, 50, 0),
            child: Center(
                child:Text(mainList ,style: TextStyle(fontSize: 22,color: Colors.white,fontFamily:'CustomFont2',fontWeight: FontWeight.bold),)),
          )
      ),
      body: Center(
        child: Container(
          width: 350,
          child: FutureBuilder(
            future: Segregator(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data==null||_notes.length==0){
                return Center(
                  child: Container(
                    child: Text("Add items",style:TextStyle(fontSize: 15,color: Colors.white,fontFamily: "CustomFont2")),
                  ),
                );
              }
              return ListView.builder(
                  itemCount:_notes.length,
                  itemBuilder: (context,index){
                    return Dismissible(
                      direction: DismissDirection.startToEnd,
                      key: Key(_notes[index].gettitle),
                      confirmDismiss:   (DismissDirection direction) async {
                         bool res=true;
                        Scaffold.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1300),
                          content: Row(
                            children: <Widget>[
                              Icon(Icons.delete),
                              Text("Item Deleted"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(110, 0, 0, 0),
                                child: Container(
                                  height: 33,
                                  child: IconButton(
                                    icon: Icon(Icons.undo,color: Colors.blue[400],),
                                    onPressed: (){
                                      res=false;
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                        com=false;
                         await Future.delayed(Duration(milliseconds: 1300));
                         com=true;
                         return res;
                      },
                      onDismissed: (direction){
                        setState(() {
                          Delete2(_notes[index].gettitle);
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
                          height: 120,
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color: Color(0x34495E),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 130,
                                    child: Text(_notes[index].gettitle,maxLines:2,textAlign:TextAlign.start,overflow: TextOverflow.ellipsis,style: TextStyle(
                                        color: color1(_notes[index]),fontWeight:FontWeight.bold,fontSize: 20,fontFamily:'CustomFont2'),),
                                  ),
                                  Container(
                                    width: 114,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(pcs1(_notes[index].getpcs),style: TextStyle(fontSize: 15,color:color2(_notes[index]),fontWeight: FontWeight.bold),),
                                              Text(pcs2(_notes[index].getpcs),style: TextStyle(fontSize: 18,color: color1(_notes[index])),),
                                            ],
                                          ),
                                          Divider(color: divider(_notes[index]),indent: 15,endIndent: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(Weight1(_notes[index].getweight),style: TextStyle(fontSize: 15,color: color2(_notes[index]),fontWeight: FontWeight.bold),),
                                              Text(Weight2(_notes[index].getweight),style: TextStyle(fontSize: 18,color: color1(_notes[index])),),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 0,50),
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      child: FloatingActionButton(
                                        heroTag: "a" "$index",
                                        onPressed: (){
                                          setState(() {
                                            Tick(_notes[index]);
                                          });
                                        },
                                        backgroundColor: color(_notes[index]),
                                        child: Icon(icon(_notes[index])),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap:() {
                                showDialog(context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context)=>Dialogue(snapshot.data[index]),
                              );
                              },
                              onLongPress: (){
                                Deletedialg2(_notes[index].gettitle);
                              },
                            ),
                          )
                      ),
                    );}
              );
            },
          ),
        ),
      ),
      floatingActionButton: Center(
        heightFactor: 0.7,
        widthFactor: 0.8,
        child: FloatingActionButton(
          heroTag: "btn1",
          onPressed: (){//Bottom popup
            if(com==true){
              showModalBottomSheet(context: context,elevation: 5.0,
                  backgroundColor: Colors.transparent,isScrollControlled: true, builder:(BuildContext bc )=>Popup(mainList,_notes,database,Refrsh,key));
            }
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Delete2(String arg)async{
    setState(()async {
      await deleter().secondarydelete(arg,mainList);
      _notes=await database.lists(mainList);
    });
    return _notes ;
  }

  Deletedialg2(String strr){
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
                      Text("Delete",style: TextStyle(fontSize: 25,color:Colors.white70,fontFamily: "CustomFont2"),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FlatButton(
                              color: Colors.blue,
                              onPressed: (){
                                setState(() {
                                  Delete2(strr);
                                  Navigator.pop(context);
                                });
                              },
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Text("Yes",style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                            FlatButton(
                              color: Colors.blue,
                              onPressed: (){
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Text("Cancel",style: TextStyle(fontSize: 18,color: Colors.white),),
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
}








