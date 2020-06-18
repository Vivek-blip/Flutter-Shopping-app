import 'package:shoppinglist/Util/mainDatabase.dart';
import 'package:shoppinglist/Util/secondDatabase.dart';

class deleter{

  maindeleter(String given)async{
    await base1().deletedata(given);
    await base2().deletedata(given);
  }

  secondarydelete(String giv,String lis)async{
    await base2().seconddeletedata(giv,lis);
  }

  Editdata(String strr,String newName)async{
    await base2().Editdata2(strr, newName);
    await base1().Editdata1(strr, newName);


  }
}