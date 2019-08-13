import 'package:flutter/material.dart';

import 'package:xnote/DB/ClientModel.dart';
import 'package:xnote/DB/DBIf.dart';
//import 'NoteDetail.dart';
import 'XNote.dart';
import 'XIcon.dart';
//import 'XNoteTypeMenu.dart';

class NoteItemView extends ListTile{
  final XNoteItem item;
  final XNoteState _state;
  NoteItemView( this.item, this._state);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.description),
      //leading: Text(item.id.toString()),
      leading: XNoteTypeIcon(xNoteItem: item),
      onTap: ()async {
        //final XNoteType deptName = await XNoteTypeMenu.asyncSimpleDialog(context);
      },
      trailing: Checkbox(
        onChanged: (bool value) {
          DBProvider.db.blockOrUnblock(item);
          _state.callbackSetState();
        },
        value: item.blocked,
      ),
    );
  }
  static ListTile viewTitle(XNoteItem item, XNoteState theState ){
    return ListTile(
      title: Text(item.description),
      leading: Text(item.id.toString()),
      //leading: XIcon(xNoteType: 1),
      onTap: (){

      },
      trailing: Checkbox(
        onChanged: (bool value) {
          DBProvider.db.blockOrUnblock(item);
          theState.callbackSetState();
        },
        value: item.blocked,
      ),
    );
  }
}