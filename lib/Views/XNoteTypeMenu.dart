import 'package:flutter/material.dart';
import 'package:xnote/DB/Language.dart';

import 'XIcon.dart';

class XNoteTypeMenuSelect1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      SimpleDialog(
        title: const Text('XNoteTypeMenuSelect '),
        //children: XNoteType.values.map((x) => getMenuType(x)).toList(),
        children: XNoteType.values.map((x) => new SimpleDialogOption(
          onPressed: () {
            print("context: " + context.toString());
            Navigator.pop(context, XNoteType.values[x.index]);
          },
          child: Row( children: <Widget>[
            CircleAvatar(
                backgroundColor: XNoteTypeIcon.xType2BColors[x],
                child: Icon(
                  XNoteTypeIcon.xType2Icons[x],
                  color: Colors.white,
                )
            ),
            Text(XNoteTypeIcon.xType2Name[x]),
          ],) ,
        )).toList(),
      );
  }

}
class XNoteTypeMenuSelect2{
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
              XNoteTypeIcon.xType2Icons[xNoteType],
              color: Colors.white,)
        ),
        Text(DemoLocalizations.title),
      ],) ,
    );
  }
  static Future<XNoteType> asyncSimpleDialog(BuildContext context) async {
    return await showDialog<XNoteType>(
        context: context,

        barrierDismissible: true,

        builder: (context) {
          return
            SimpleDialog(
              title: const Text('XNoteTypeMenuSelect '),
              children: XNoteType.values.map((x) => new SimpleDialogOption(
                onPressed: () {
                  print("context: " + context.toString());
                  Navigator.of(context).pop(XNoteType.values[x.index]);
                },
                child: Row( children: <Widget>[
                  CircleAvatar(
                      backgroundColor: XNoteTypeIcon.xType2BColors[x],
                      child: Icon(
                        XNoteTypeIcon.xType2Icons[x],
                        color: Colors.white,
                      )
                  ),
                  Text(XNoteTypeIcon.xType2Name[x]),
                ],) ,
              )
              ).toList(),
            );
        }

        );
  }
}
