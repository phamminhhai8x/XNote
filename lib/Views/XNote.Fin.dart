import 'package:flutter/material.dart';

import 'package:xnote/DB/ClientModel.dart';
import 'package:xnote/DB/DBIf.dart';
import 'NoteItemView.dart';
import 'XNote.dart';

class XNoteFin extends StatelessWidget {
  final XNoteState _state;
  XNoteFin(this._state);

  static XNoteFin getXNoteFin(XNoteState theState){
    return XNoteFin(theState);
  }

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
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  DBProvider.db.deleteClient(item.id);
                },
                //child: NoteItemView.viewTitle(item, this),
                child: NoteItemView(item, this._state),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
