import 'package:flutter/material.dart';
import 'package:xnote/DB/ClientModel.dart';
import 'package:xnote/DB/DBIf.dart';

import 'XNoteTypeMenu.dart';

enum XNoteType {
  tAddNote,
  tBaseNote,
  tFinInCom,
  tFinCart,
  tFinCommonlyOut,
  tFinEducation,
  tFinEntertainment,
  tFinRestaurant,
  tUnknownNote
}
class XNoteTypeIcon extends StatelessWidget{

  static final Map<XNoteType, IconData> xType2Icons = {
    XNoteType.tAddNote : Icons.add,
    XNoteType.tBaseNote : Icons.note,
    XNoteType.tFinInCom : Icons.monetization_on,
    XNoteType.tFinCart : Icons.shopping_cart,
    XNoteType.tFinCommonlyOut : Icons.loop,
    XNoteType.tFinEducation : Icons.school,
    XNoteType.tFinEntertainment : Icons.tag_faces,
    XNoteType.tFinRestaurant : Icons.restaurant,
    XNoteType.tUnknownNote : Icons.all_inclusive
  };
  static final Map<XNoteType, Color> xType2BColors = {
    XNoteType.tAddNote : Colors.green,
    XNoteType.tBaseNote : Colors.green,
    XNoteType.tFinInCom : Colors.blue,
    XNoteType.tFinCart : Colors.red[800],
    XNoteType.tFinCommonlyOut : Colors.yellow[400],
    XNoteType.tFinEducation : Colors.blue,
    XNoteType.tFinEntertainment : Colors.orangeAccent,
    XNoteType.tFinRestaurant : Colors.red,
    XNoteType.tUnknownNote : Colors.green
  };
  static final Map<XNoteType, String> xType2Name = {
    XNoteType.tAddNote : "Add",
    XNoteType.tBaseNote : "Note",
    XNoteType.tFinInCom : "InCome",
    XNoteType.tFinCart : "Groceries",
    XNoteType.tFinCommonlyOut : "Utilities",
    XNoteType.tFinEducation : "Education",
    XNoteType.tFinEntertainment : "Entertainment",
    XNoteType.tFinRestaurant : "Restaurant",
    XNoteType.tUnknownNote : "Misc"
  };


  final XNoteItem xNoteItem;

  const XNoteTypeIcon({Key key, this.xNoteItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _navigateAndDisplaySelection(context);
      },
      child: CircleAvatar(
          backgroundColor: xType2BColors[XNoteType.values[xNoteItem.xNoteType]],
          child: Icon(
            xType2Icons[XNoteType.values[xNoteItem.xNoteType]],
            color: Colors.white,)
      ),
    )
    ;
  }
  _navigateAndDisplaySelection(BuildContext context) async {

    final XNoteType xNoteType = await XNoteTypeMenuSelect2.asyncSimpleDialog(context);
//    final XNoteType xNoteType = await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => XNoteTypeMenuSelect1(), maintainState: false),
//    );
    if(xNoteType != null) {
      print("abcd");
      print(xNoteType.index);
      xNoteItem.xNoteType = xNoteType.index;
      DBProvider.db.updateClient(xNoteItem);
    }
  }
}