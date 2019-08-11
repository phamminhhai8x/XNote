import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
//import 'dart:math' as math;
import '../ClientModel.dart';
import '../DBIf.dart';
import 'NoteDetail.dart';


class NoteItemView extends ListTile{
  final NoteItem item;
  final XNoteState _state;
  NoteItemView( this.item, this._state);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.lastName),
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
  static ListTile viewTitle(NoteItem item, XNoteState theState ){
    return ListTile(
      title: Text(item.lastName),
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
class XNote extends StatefulWidget {
  @override
  XNoteState createState() => XNoteState();
}

class XNoteState extends State<XNote> {
  // data for testing
  List<NoteItem> testClients = [
    NoteItem(firstName: "Raouf", lastName: "Rahiche", blocked: false),
    NoteItem(firstName: "Zaki", lastName: "oun", blocked: true),
    NoteItem(firstName: "oussama", lastName: "ali", blocked: false),
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
                FutureBuilder<List<NoteItem>>(
                  future: DBProvider.db.getAllClients(),

                  builder: (BuildContext context, AsyncSnapshot<List<NoteItem>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          NoteItem item = snapshot.data[index];
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
                Icon(Icons.directions_bike),
                Icon(Icons.directions_bike),
              ],
            ),
//            floatingActionButton: FloatingActionButton(
//              child: Icon(Icons.add),
//              onPressed: () async {
//                NoteItem rnd = testClients[math.Random().nextInt(testClients.length)];
//                await DBProvider.db.newClient(rnd);
//                setState(() {});
//                },
//            ),
          ),
        ),
    );
  }
}
