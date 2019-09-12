import 'package:flutter/material.dart';
import 'package:xnote/Common/XTypeCommon.dart';

import 'package:xnote/DB/XNoteItem.dart';
import 'package:xnote/DB/DBIf.dart';
//import 'NoteDetail.dart';
import 'XNote.dart';
import 'XIcon.dart';
import 'XNoteType.dart';
//import 'XNoteType.dart';

class NoteItemView extends ListTile{
  final XNoteItem item;
  final XNoteState _state;
  NoteItemView( this.item, this._state);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.description),
      leading: XNoteTypeIcon(
          xNoteItem: item,
          onTap: () async {
            XNoteType xNoteType = await XNoteTypeMenu.asyncSelectNoteTypeDialog(context);
            if(xNoteType != null) {
              item.xNoteType = xNoteType.index;
              DBProvider.db.updateClient(item);
              _state.callbackSetState();
            }
          },
      ),
      trailing: Checkbox(
        onChanged: (bool value) {
          DBProvider.db.blockOrUnblock(item);
          _state.callbackSetState();
        },
        value: item.blocked,
      ),
    );
  }
//  static ListTile viewTitle(XNoteItem item, XNoteState theState ){
//    return ListTile(
//      title: Text(item.description),
//      leading: Text(item.id.toString()),
//      //leading: XIcon(xNoteType: 1),
//      onTap: (){
//
//      },
//      trailing: Checkbox(
//        onChanged: (bool value) {
//          DBProvider.db.blockOrUnblock(item);
//          theState.callbackSetState();
//        },
//        value: item.blocked,
//      ),
//    );
//  }
}