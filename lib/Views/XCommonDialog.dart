import 'package:flutter/material.dart';
import 'package:xnote/Common/XTypeCommon.dart';
class XCommonDialog{
  static Future<bool> xAlertDialog(BuildContext context, {Object dummy}) async {
    xLog(context);
    final bool res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          xLog(context);
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you wish to delete this item?"),
            actions: <Widget>[
              FlatButton(onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("DELETE")
              ),

              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("CANCEL"),)
            ],
          );
        });
    return res;
  }
}

