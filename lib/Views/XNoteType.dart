import 'package:flutter/material.dart';

enum XNoteType {
  tAddNote,
  tBaseNote,
  tFinInCom,
  tFinCart,
  tFinCommonlyOut,
  tFinEducation,
  tFinEntertainment,
  tFinRestaurant,
  tUnknownNote
}
//final Map<XNoteType, IconData> xNoteType2Icons = {
//  XNoteType.tAddNote : Icons.add,
//  XNoteType.tBaseNote : Icons.note,
//  XNoteType.tFinInCom : Icons.monetization_on,
//  XNoteType.tFinCart : Icons.shopping_cart,
//  XNoteType.tFinCommonlyOut : Icons.loop,
//  XNoteType.tFinEducation : Icons.school,
//  XNoteType.tFinEntertainment : Icons.tag_faces,
//  XNoteType.tFinRestaurant : Icons.restaurant,
//  XNoteType.tUnknownNote : Icons.all_inclusive
//};
//final Map<XNoteType, Color> xNoteType2BColors = {
//  XNoteType.tAddNote : Colors.green,
//  XNoteType.tBaseNote : Colors.green,
//  XNoteType.tFinInCom : Colors.blue,
//  XNoteType.tFinCart : Colors.red[800],
//  XNoteType.tFinCommonlyOut : Colors.yellow[400],
//  XNoteType.tFinEducation : Colors.blue,
//  XNoteType.tFinEntertainment : Colors.orangeAccent,
//  XNoteType.tFinRestaurant : Colors.red,
//  XNoteType.tUnknownNote : Colors.green
//};
//final Map<XNoteType, String> xNoteType2Name = {
//  XNoteType.tAddNote : "Add",
//  XNoteType.tBaseNote : "Note",
//  XNoteType.tFinInCom : "InCome",
//  XNoteType.tFinCart : "Groceries",
//  XNoteType.tFinCommonlyOut : "Utilities",
//  XNoteType.tFinEducation : "Education",
//  XNoteType.tFinEntertainment : "Entertainment",
//  XNoteType.tFinRestaurant : "Restaurant",
//  XNoteType.tUnknownNote : "Misc"
//};
@immutable
class XNoteTypeIconData{
  final XNoteType type;
  final IconData icon;
  final Color bgrColor;
  final String nameType;
  const XNoteTypeIconData({this.type, this.icon, this.bgrColor, this.nameType });
}
class XNoteTypeIcons {
  XNoteTypeIcons._();
  static final List<XNoteTypeIconData> data =
  [
    new XNoteTypeIconData(type: XNoteType.values[0], icon: Icons.add, bgrColor: Colors.green, nameType: "Add"),
    new XNoteTypeIconData(type: XNoteType.values[1], icon: Icons.note, bgrColor: Colors.green, nameType: "Note"),
    new XNoteTypeIconData(type: XNoteType.values[2], icon: Icons.monetization_on, bgrColor: Colors.blue, nameType: "InCome"),
    new XNoteTypeIconData(type: XNoteType.values[3], icon: Icons.shopping_cart, bgrColor: Colors.red[800], nameType: "Groceries"),
    new XNoteTypeIconData(type: XNoteType.values[4], icon: Icons.loop, bgrColor: Colors.yellow[400], nameType: "Utilities"),
    new XNoteTypeIconData(type: XNoteType.values[5], icon: Icons.school, bgrColor: Colors.blue, nameType: "Education"),
    new XNoteTypeIconData(type: XNoteType.values[6], icon: Icons.tag_faces, bgrColor: Colors.orangeAccent, nameType: "Entertainment"),
    new XNoteTypeIconData(type: XNoteType.values[7], icon: Icons.restaurant, bgrColor: Colors.red, nameType: "Restaurant"),
    new XNoteTypeIconData(type: XNoteType.values[8], icon: Icons.all_inclusive, bgrColor: Colors.brown, nameType: "Misc"),
  ];
}
class XNoteTypeMenu{
  static BuildContext myContext;

//  static Future<XNoteType> navigateAndDisplaySelection(BuildContext context) async {
//
//    XNoteType xNoteType = await asyncSimpleDialog(context);
//    return xNoteType;
//  }

  static Future<XNoteType> asyncSelectNoteTypeDialog(BuildContext context) async {
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
