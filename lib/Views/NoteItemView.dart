import 'package:flutter/material.dart';

import 'package:xnote/DB/ClientModel.dart';
import 'package:xnote/DB/DBIf.dart';
import 'NoteDetail.dart';
import 'XNote.dart';

class NoteItemView extends ListTile{
  final XNoteItem item;
  final XNoteState _state;
  NoteItemView( this.item, this._state);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.description),
      leading: Text(item.id.toString()),
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => NoteDetail(theItem: item),
          ),
        );
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