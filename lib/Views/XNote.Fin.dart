import 'package:flutter/material.dart';
import 'package:xnote/Common/XTypeCommon.dart';

import 'package:xnote/DB/ClientModel.dart';
import 'package:xnote/DB/DBIf.dart';
import 'NoteItemView.dart';
import 'XCommonDialog.dart';
import 'XNote.dart';
import 'XNoteType.dart';

class XNoteFin extends StatelessWidget {
  final XNoteState _state;
  XNoteFin(this._state);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<XNoteItem>>(
      future: DBProvider.db.getBlockedClients(),

      builder: (BuildContext context, AsyncSnapshot<List<XNoteItem>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              XNoteItem item = snapshot.data[index];
              return Dismissible(
                key: UniqueKey(),
                background: Container(),
                confirmDismiss: (DismissDirection direction) async {
                  return XCommonDialog.xAlertDialog(context);
                },
                onDismissed: (direction)  {
                  xLog("onDismissed");
                },
                child: NoteItemView(item, _state),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  static Future<XNoteType> asyncEditNoteFin(BuildContext context) async {
    return await showDialog<XNoteType>
      (
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return
            SimpleDialog(
              title: const Text('XNoteTypeMenuSelect '),
              children: XNoteType.values.map((x) => new SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, XNoteType.values[x.index]);
                },
                child: Row( children: <Widget>[
                  CircleAvatar(
                      backgroundColor: XNoteTypeIcons.data[x.index].bgrColor,
                      child: Icon(
                        XNoteTypeIcons.data[x.index].icon,
                        color: Colors.white,
                      )
                  ),
                  //Text(xNoteType2Name[x]),
                  Text(" " + XNoteTypeIcons.data[x.index].nameType),
                ],) ,
              )
              ).toList(),
            );
        }
    );
  }
}
