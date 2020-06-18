import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:shoppinglist/SecondPage.dart';
import 'package:shoppinglist/Util/mainDatabase.dart';
import 'package:shoppinglist/Util/Datadumper.dart';

class ListDialg extends StatefulWidget {
  List<String>database2;
  ListDialg(this.database2);
  @override
  _ListDialgState createState() => _ListDialgState(database2);
}

class _ListDialgState extends State<ListDialg> with SingleTickerProviderStateMixin {
  int count=0;
  List<String>database2;
  _ListDialgState(this.database2);
  AnimationController animController;
  Animation<double> animation;
  var variable=base1();

  String txtInp;

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

  String error(String inp){
    if(database2!=null) {
      for (int k = 0; k < database2.length;k++) {
        if(database2[k]==inp){
          return "List already exist";
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale:animation.value,
        child: Dialog(
            backgroundColor: Color(0xCCffffff),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
    height: 200,
    width: 200,
    child:Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Container(
        child: Column(
          children: <Widget>[
            Text("New List",style: TextStyle(fontSize: 25,color:Colors.grey[800],fontFamily: "CustomFont2"),),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5,0),
              child: Container(
                width: 220,
                child: TextField(
                  maxLength: 20,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.list),
                  hintText: "Title",hintStyle: TextStyle(fontSize: 15,fontFamily: "CustomFont2"),errorText: error(txtInp)),
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (localinp){
                    txtInp=localinp;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,10, 0,0),
              child: FlatButton(
                color: Colors.blue,
                onPressed: (){
                  setState(() {
                    print(txtInp);
                    if(txtInp!=null&&txtInp!="") {
                      count=0;
                      if(database2!=null) {
                        for (int k = 0; k < database2.length;k++) {
                          if(database2[k]==txtInp){
                            count=1;
                            break;
                          }
                        }
                        }
                      if(count!=1){
                        variable.insertdata(Reciever(mainList: txtInp));
                        count=0;
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Home(txtInp)));

                      }
                    }
                  });
                },
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text("Add",style: TextStyle(fontSize: 18,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    ),

    ),
    ),
    );
  }
}



class ListeditDialg extends StatefulWidget {
  List<String>database2;
  String strr;
  ListeditDialg(this.database2,this.strr);
  @override
  _ListeditDialgState createState() => _ListeditDialgState(database2,strr);
}

class _ListeditDialgState extends State<ListeditDialg> with SingleTickerProviderStateMixin {
  int count = 0;
  List<String>database2;
  String strr;

  _ListeditDialgState(this.database2, this.strr);

  AnimationController animController;
  Animation<double> animation;
  var variable = deleter();

  String txtInp;

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(duration: Duration(milliseconds: 190), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animController)
      ..addListener(() {
        setState(() {

        });
      });
    animController.forward();
  }

  String error(String inp) {
    if (database2 != null) {
      for (int k = 0; k < database2.length; k++) {
        if (database2[k] == inp) {
          return "List already exist";
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Dialog(
        backgroundColor: Color(0xCCffffff),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 200,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Text("Edit Title", style: TextStyle(fontSize: 25,
                      color: Colors.grey[800],
                      fontFamily: "CustomFont2"),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                    child: Container(
                      width: 220,
                      child: TextField(
                        maxLength: 20,
                        decoration: InputDecoration(prefixIcon: Icon(
                            Icons.list),
                            hintText: "Title",
                            hintStyle: TextStyle(
                                fontSize: 15, fontFamily: "CustomFont2"),
                            errorText: error(txtInp)),
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (localinp) {
                          txtInp = localinp;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          print(txtInp);
                          if (txtInp != null && txtInp != "") {
                            count = 0;
                            if (database2 != null) {
                              for (int k = 0; k < database2.length; k++) {
                                if (database2[k] == txtInp) {
                                  count = 1;
                                  break;
                                }
                              }
                            }
                            if (count != 1){
                              variable.Editdata(strr, txtInp);
                              count = 0;
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>Home(txtInp)));
                            }
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Edit", style: TextStyle(fontSize: 18, color: Colors
                          .white),),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}
