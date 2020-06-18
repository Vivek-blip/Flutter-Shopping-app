import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:shoppinglist/Util/secondDatabase.dart';


class Dialogue extends StatefulWidget {
  Reciever1 data;
  Dialogue(this.data);
  @override
  _DialogueState createState() => _DialogueState(data);
}

class _DialogueState extends State<Dialogue> with SingleTickerProviderStateMixin{
  Reciever1 data;
  _DialogueState(this.data);
  AnimationController animController;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    animController= AnimationController(duration: Duration(milliseconds: 190),vsync: this);
    animation=Tween<double>(begin: 0,end: 1).animate(animController)
      ..addListener((){
        setState(() {

        });
      });
    animController.forward();
  }

  pcs2(String arg){
    if(arg==".."||arg==""){
      return " ";
    }
    else{
      return arg;
    }
  }
  Weight2(String arg){
    if(arg=="..Kg"||arg=="..g"||arg=="Kg"||arg=="g"){
      return " ";
    }
    else{
      return arg;
    }
  }

  notes(String arg){
    if(arg==".."||arg==""){
      return " ";
    }
    else{
      return arg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale:animation.value,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 346,
          width: 200,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.indigo[300],width: 3,),
                  borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(0),bottomLeft: Radius.circular(0) ),color: Colors.indigo[400],
                ),
                height: 90,
                width: 300,
                child: Center(child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        height: 68,
                        child: Text(data.gettitle,style: TextStyle(color:Colors.white,fontSize: 28,fontFamily: "CustomFont2" ),)),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Colors.white30,
                      thickness: 1.2,
                    ),
                  ],
                )),
              ),
              Container(
                height: 256,
                width: 290,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(17),bottomRight: Radius.circular(17)),color: Colors.indigo[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.indigo[300],width: 3),borderRadius:
                                BorderRadius.all(Radius.circular(10)),color: Colors.grey[900]
                            ),
                            height: 70,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: 140,
                            child: Column(
                              children: <Widget>[
                                Text("Pcs",style:
                                  TextStyle(fontSize: 15,color: Colors.blue[300],fontFamily: "CustomFont2",fontWeight: FontWeight.bold),),
                                Text(pcs2(data.getpcs),style:
                                  TextStyle(fontFamily: "CustomFont2",
                                    fontSize: 32,color: Colors.white
                                  ),)
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.indigo[300],width: 3,),borderRadius:
                                BorderRadius.all(Radius.circular(10)),color: Colors.grey[900]
                            ),
                            height: 70,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: 140,
                            child: Column(
                              children: <Widget>[
                                Text("Weight",style:
                                TextStyle(fontSize: 15,color:  Colors.blue[300],fontFamily: "CustomFont2",fontWeight: FontWeight.bold),),
                                Text(Weight2(data.getweight),style:
                                TextStyle(fontFamily: "CustomFont2",
                                    fontSize: 32,color: Colors.white
                                ),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 173,
                        width: 290,
                        decoration: BoxDecoration(
                          border: Border.all(color:Colors.indigo[300],width: 3),color: Colors.grey[900],borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topRight: Radius.circular(10),topLeft: Radius.circular(10))
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 9, 200,0),
                              child: Center(
                                child: Text("Note :",style:
                                TextStyle(fontSize: 15,color:  Colors.blue[300],fontFamily: "CustomFont2",fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(55, 5, 0, 0),
                                child: Container(
                                    width: 200,
                                    child: Text(notes(data.getnote),style:
                                    TextStyle(fontSize: 20,color: Colors.white,fontFamily: "CustomFont2",fontWeight: FontWeight.bold),)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animController.dispose();
    super.dispose();
  }
}