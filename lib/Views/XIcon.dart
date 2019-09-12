import 'package:flutter/material.dart';
import 'package:xnote/Common/XTypeCommon.dart';
import 'package:xnote/DB/XNoteItem.dart';
import 'package:xnote/DB/DBIf.dart';

import 'XNoteType.dart';



class XNoteTypeIcon extends GestureDetector{



  final XNoteItem xNoteItem;
  final XIconTapCallback onTap;

  XNoteTypeIcon({this.xNoteItem, this.onTap});

  //const XNoteTypeIcon({Key key, this.xNoteItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: this.onTap ?? (){
        this.onTap();
      },
      child: CircleAvatar(
          backgroundColor: XNoteTypeIcons.data[xNoteItem.xNoteType].bgrColor,
          child: Icon(
            XNoteTypeIcons.data[xNoteItem.xNoteType].icon,
            color: Colors.white,)
      ),
    )
    ;
  }

}