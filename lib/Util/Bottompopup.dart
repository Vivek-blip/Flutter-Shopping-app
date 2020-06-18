import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/Util/secondDatabase.dart';

class Popup extends StatefulWidget {
  String mainList;
  var database;
  List<Reciever1> _notes;
  Function rfrsh;
  Popup(this.mainList,this._notes,this.database,this.rfrsh,Key key);
  @override
  _PopupState createState() => _PopupState(mainList,database,_notes);
}

class _PopupState extends State<Popup> {
  final TextEditingController _controller0=new TextEditingController();
  final TextEditingController _controller1=new TextEditingController();
  final TextEditingController _controller2=new TextEditingController();
  final TextEditingController _controller3=new TextEditingController();
  _PopupState(this.mainList,this.database,this._notes);
  String mainList;
  List<Reciever1> _notes;
  var database;
  String unit="Kg";
  String item;
  int count=0;
  String pcs="..";
  String weight="..";
  String note="..";


  reffresh()async{
    _notes=await database.lists(mainList);
  }


  List<bool> bul=[true,false];
  Toggle([index]) {
    if(index!=null) {
      setState(() {
        if (bul[index] == false) {
          bul[index] = true;
          if (index == 0) {
            unit = "Kg";
            bul[1] = false;
          }
          else {
            bul[0] = false;
            unit = "g";
          }
        }
      });
    }
    return bul;
  }


  SaveData()async{
    if(weight!=null) {
      weight = weight + unit;
    }
    await database.insertdata(Reciever1(mainlist: mainList,title: item,pcs: pcs,weight: weight,note: note,boool:"0"));
    item=null;
    pcs="..";
    weight="..";
    note="..";
    _controller0.clear();
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    widget.rfrsh();
    reffresh();
  }

  String error(String inp){
    if(_notes!=null) {
      for (int k = 0; k < _notes.length;k++) {
        if(_notes[k].gettitle==item){
          return "Item already exist";
        }
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      height:695,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),color: Color(0xCCffffff), ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 0,0 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                height: 50,
                child: Text("New Item",style: TextStyle(fontSize: 25,color:Colors.grey[800],fontFamily: "CustomFont2"),),
              ),
            ),
            Container(
              width: 250,
              child: TextField(
                maxLength: 20,
                decoration: InputDecoration(prefixIcon:Icon(Icons.shopping_cart),focusColor: Colors.white,hintText: "Item",
                    hintStyle: TextStyle(
                        fontSize: 18,fontFamily: "CustomFont2"),errorText: error(item))
                ,style: TextStyle(fontSize: 23,
              ),
                controller: _controller0,
                onChanged: (lc1){
                  item=lc1;
                },
                autofocus:true,keyboardType:TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textAlign: TextAlign.start,),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0,30),
                  width: 100,
                  child: TextField(
                    maxLength: 4,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.add),
                        hintText: "Pcs",hintStyle: TextStyle(
                            fontSize: 18,fontFamily: "CustomFont2")),style: TextStyle(fontSize: 23,
                  ),
                    controller: _controller1,
                    onChanged: (lc2){
                      pcs=lc2;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 30, 0, 0),
                  width: 170,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: TextField(
                          maxLength: 4,
                          decoration: InputDecoration(prefixIcon: Icon(Icons.line_weight),
                              hintText: "Weight",hintStyle: TextStyle(
                                  fontSize: 18,fontFamily: "CustomFont2")),style: TextStyle(fontSize: 23,
                        ),
                          controller: _controller2,
                          onChanged: (lc3){
                            weight=lc3;
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(0, 2, 0,0),
                        child:ToggleButtons(
                          borderWidth: 5,
                          fillColor: Colors.blue[200],
                          textStyle: TextStyle(color:Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          children: <Widget>[
                            Text("Kg"),
                            Text("g",),
                          ],
                          isSelected:bul,
                          onPressed: (index){
                            setState(() {
                              Toggle(index);
                            });
                          },),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: 250,
              child: TextField(
                maxLength: 80,
                decoration: InputDecoration(prefixIcon:Icon(Icons.note_add),focusColor: Colors.white,hintText: "Notes",
                    hintStyle: TextStyle(
                        fontSize: 18,fontFamily: "CustomFont2")),style: TextStyle(fontSize:20,
              ),
                controller: _controller3,
                onChanged: (lc4){
                  note=lc4;
                },
                autofocus:false,keyboardType:TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                textAlign: TextAlign.start,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    color: Colors.blue,
                    onPressed:(){
                      setState(() {
                        if(item!=null&&item!=""){
                          count=0;
                          if(_notes!=null) {
                            for (int k = 0; k < _notes.length;k++) {
                              if(_notes[k].gettitle==item){
                                count=1;
                                break;
                              }
                            }
                          }
                          if(count!=1){
                            count=0;
                            SaveData();
                            Navigator.pop(context);
                          }
                        }

                      });
                    },
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Text("Add",style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  FlatButton(
                    color: Colors.red,
                    onPressed: (){
                      setState(() {
                        if(item!=null&&item!=""){
                          count=0;
                          if(_notes!=null) {
                            for (int k = 0; k < _notes.length;k++) {
                              if(_notes[k].gettitle==item){
                                count=1;
                                break;
                              }
                            }
                          }
                          if(count!=1){
                            count=0;
                            SaveData();
                          }
                        }
                      });

                    },
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Text("Add More",style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
