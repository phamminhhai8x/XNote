import 'package:flutter/material.dart';
import 'package:xnote/Common/XTypeCommon.dart';
//import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import 'package:xnote/DB/XNoteItem.dart';
import 'package:xnote/DB/DBIf.dart';
import 'NoteItemView.dart';
import 'XNote.Fin.dart';
import 'XNote.InputForm.dart';
import 'XNoteType.dart';

class XNote extends StatefulWidget {
  @override
  XNoteState createState() => XNoteState();
}

class XNoteState extends State<XNote> with SingleTickerProviderStateMixin {
  static int tabLen = 5;
  int _selectedTab;
  TabController _tabController;
  TabBar _myTabBar;
  FloatingActionButton _myFloatingActionButton;
  Color _bgrFABColor;

  FloatingActionButton getFAB() {
    xLog("build FAB");
    return FloatingActionButton(
      backgroundColor: _bgrFABColor,
      child: Icon(Icons.add),
      onPressed: () async {
        XNoteItem rnd = _selectedTab == 3
            ? MyCustomForm.getNote(context)
            : testClients[math.Random().nextInt(testClients.length)];
        await DBProvider.db.newClient(rnd);
        setState(() {});
      },
    );
  }

  /// Init state of XNoteState
  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: tabLen, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _bgrFABColor = Colors.green;

    _myTabBar = TabBar(
      controller: _tabController,
      labelPadding: EdgeInsetsDirectional.only(),
      tabs: [
        Container(
            width: 300.0,
            height: 50.0,
            color: Colors.green,
            padding: EdgeInsetsDirectional.only(),
            child: FittedBox(child: Text("All"), fit: BoxFit.scaleDown)),
        Container(
            width: 300.0,
            height: 50.0,
            color: Colors.amber,
            padding: EdgeInsetsDirectional.only(),
            child: FittedBox(child: Text("Life"), fit: BoxFit.scaleDown)),
        Container(
            width: 300.0,
            height: 50.0,
            color: Colors.red,
            padding: EdgeInsetsDirectional.only(),
            child: FittedBox(child: Text("Work"), fit: BoxFit.scaleDown)),
        Container(
            width: 300.0,
            height: 50.0,
            color: Colors.orange,
            padding: EdgeInsetsDirectional.only(),
            child: FittedBox(child: Text("Fin"), fit: BoxFit.scaleDown)),
        Container(
            width: 300.0,
            height: 50.0,
            color: Colors.deepPurple,
            padding: EdgeInsetsDirectional.only(),
            child: FittedBox(child: Text("Other"), fit: BoxFit.scaleDown)),
      ],
    );
    _selectedTab = _tabController.index;
    _myFloatingActionButton = getFAB();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTab = _tabController.index;
      _bgrFABColor = _selectedTab == 1 ? Colors.blue : Colors.green;

      xLog(_selectedTab);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // data for testing
  List<XNoteItem> testClients = [
    XNoteItem(
      summary: "Raouf",
      description: "Rahiche",
      blocked: false,
      xNoteType: math.Random().nextInt(XNoteType.tUnknownNote.index),
    ),
    XNoteItem(
      summary: "Zaki",
      description: "oun",
      blocked: true,
      xNoteType: math.Random().nextInt(XNoteType.tUnknownNote.index),
    ),
    XNoteItem(
      summary: "oussama",
      description: "ali",
      blocked: false,
      xNoteType: math.Random().nextInt(XNoteType.tUnknownNote.index),
    ),
  ];

  void callbackSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: tabLen,
        child: Scaffold(
          appBar: AppBar(
              title: Text("X-Note"),
              backgroundColor: Colors.blue,
              bottom: _myTabBar),
          body: TabBarView(
            controller: _tabController,
            children: [
              Icon(Icons.directions_car),
              FutureBuilder<List<XNoteItem>>(
                future: DBProvider.db.getAllClients(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<XNoteItem>> snapshot) {
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
          floatingActionButton: _myFloatingActionButton,
        ),
      ),
    );
  }
}
