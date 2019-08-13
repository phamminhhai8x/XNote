import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import 'package:xnote/DB/ClientModel.dart';
import 'package:xnote/DB/DBIf.dart';
import 'NoteItemView.dart';
import 'XNote.Fin.dart';
import 'XIcon.dart';


class XNote extends StatefulWidget {
  @override
  XNoteState createState() => XNoteState();
}

class XNoteState extends State<XNote> {
  // data for testing
  List<XNoteItem> testClients = [
    XNoteItem(
      summary: "Raouf",
      description: "Rahiche",
      blocked: false,
      xNoteType: math.Random().nextInt(XNoteType.tUnknownNote.index),
    ),
    XNoteItem(summary: "Zaki", description: "oun", blocked: true,
      xNoteType: math.Random().nextInt(XNoteType.tUnknownNote.index),),
    XNoteItem(summary: "oussama", description: "ali", blocked: false,
      xNoteType: math.Random().nextInt(XNoteType.tUnknownNote.index),),
  ];
  void callbackSetState(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              title: Text("X-Note"),
              backgroundColor: Colors.blue,

              bottom: TabBar(
                labelPadding: EdgeInsetsDirectional.only(),
                  tabs: [
                    Container(
                      width: 300.0,
                      height: 50.0,
                      color: Colors.green,
                      padding: EdgeInsetsDirectional.only(),
                      child:  FittedBox(
                        child: Text("All"),
                        fit: BoxFit.scaleDown
                      )
                    ),
                    Container(
                        width: 300.0,
                        height: 50.0,
                        color: Colors.amber,
                        padding: EdgeInsetsDirectional.only(),
                        child:  FittedBox(
                            child: Text("Life"),
                            fit: BoxFit.scaleDown
                        )
                    ),
                    Container(
                        width: 300.0,
                        height: 50.0,
                        color: Colors.red,
                        padding: EdgeInsetsDirectional.only(),
                        child:  FittedBox(
                            child: Text("Work"),
                            fit: BoxFit.scaleDown
                        )
                    ),
                    Container(
                        width: 300.0,
                        height: 50.0,
                        color: Colors.orange,
                        padding: EdgeInsetsDirectional.only(),
                        child:  FittedBox(
                            child: Text("Fin"),
                            fit: BoxFit.scaleDown
                        )
                    ),
                    Container(
                        width: 300.0,
                        height: 50.0,
                        color: Colors.deepPurple,
                        padding: EdgeInsetsDirectional.only(),
                        child:  FittedBox(
                            child: Text("Other"),
                            fit: BoxFit.scaleDown
                        )
                    ),
                  ],

              ),
            ),
            body: TabBarView(
              children: [
                Icon(Icons.directions_car),
                FutureBuilder<List<XNoteItem>>(
                  future: DBProvider.db.getAllClients(),

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
                            child: NoteItemView(item, this),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),

                Icon(Icons.access_alarm),
                XNoteFin(this),
                Icon(Icons.directions_bike),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                XNoteItem rnd = testClients[math.Random().nextInt(testClients.length)];
                await DBProvider.db.newClient(rnd);
                setState(() {});
                },
            ),
          ),
        ),
    );
  }
}
