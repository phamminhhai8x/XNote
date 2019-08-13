import 'package:flutter/material.dart';
import 'package:xnote/DB/ClientModel.dart';

import 'XNoteTypeMenu.dart';

enum XNoteType {
  tAddNote,
  tBaseNote,
  tFinInCom,
  tFinCart,
  tFinCommonlyOut,
  tFinEducation,
  tFinEntertainment,
  tUnknownNote
}
class XNoteTypeIcon extends StatelessWidget{

  static final Map<XNoteType, IconData> xIconList = {
    XNoteType.tAddNote : Icons.add,
    XNoteType.tBaseNote : Icons.note,
    XNoteType.tFinInCom : Icons.monetization_on,
    XNoteType.tFinCart : Icons.shopping_cart,
    XNoteType.tFinCommonlyOut : Icons.loop,
    XNoteType.tFinEducation : Icons.school,
    XNoteType.tFinEntertainment : Icons.tag_faces,
    XNoteType.tUnknownNote : Icons.memory
  };


  final XNoteItem xNoteItem;

  const XNoteTypeIcon({Key key, this.xNoteItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {
        // ignore: unused_local_variable
        final XNoteType deptName = await XNoteTypeMenu.asyncSimpleDialog(context);
      },
      child: CircleAvatar(
          backgroundColor: Colors.green,
          //child: Icon(Icons.shopping_cart, color: Colors.white,)
          child: Icon(
            xIconList[XNoteType.values[xNoteItem.xNoteType]],
            color: Colors.white,)
      ),
    )
    ;
  }
}