import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:xnote/DB/XNoteItem.dart';
import 'package:xnote/DB/DBIf.dart';

class NoteDetail extends StatelessWidget{
  final teFirstName = TextEditingController();
  final teLastName = TextEditingController();
  final teID = TextEditingController();


  final XNoteItem theItem;
  final FocusNode myFocus = new FocusNode();
  NoteDetail({Key key, @required this.theItem}) : super(key: key){
    teFirstName.text = theItem.summary;

    teLastName.text = theItem.description;
    teID.text = theItem.id.toString();
  }


  Future<bool> _willPopCallback() async {
    DBProvider.db.updateClient(theItem);
    return true; // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _willPopCallback,
      child: new Scaffold(
          appBar: new AppBar(
            title: new TextField(
              controller: teFirstName,

            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: new TextField(
              controller: teLastName,
              onChanged: (text){
                theItem.description = text;
              },
            ),
          )
      )
    );

  }

}