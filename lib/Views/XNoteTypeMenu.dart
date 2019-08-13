import 'package:flutter/material.dart';
import 'package:xnote/DB/Language.dart';

import 'XIcon.dart';

enum Departments { Production, Research, Purchasing, Marketing, Accounting }
class XNoteTypeMenu{
  static BuildContext myContext;
  static Widget getMenuType(XNoteType xNoteType){
    return new SimpleDialogOption(
      onPressed: () {
        Navigator.pop(myContext, XNoteType.tBaseNote);
      },
      child: Row( children: <Widget>[
        CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(
              XNoteTypeIcon.xIconList[xNoteType],
              color: Colors.white,)
        ),
        //Text(xNoteType.toString()),
        Text(DemoLocalizations.title),
      ],) ,
    );
  }
  static Future<XNoteType> asyncSimpleDialog(BuildContext context) async {
    return await showDialog<XNoteType>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select change type '),
            children: XNoteType.values.map((x) => getMenuType(x)).toList(),
          );
        });
  }
}
