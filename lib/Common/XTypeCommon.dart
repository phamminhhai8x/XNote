
//import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';

typedef XIconTapCallback = void Function();

void xLog(Object o) {
  assert(() {
    print(
        "xLog ----------------------------------------------------------------" +
        "\n" + Trace.current(3).frames[1].member + " :=> "+ Trace.current(3).frames[1].location +
        "\n \t-> " +Trace.current(2).frames[1].member + " :=> "+ Trace.current(2).frames[1].location +
        "\n \t\t-> " + Trace.current(1).frames[1].member + " :=> "+ Trace.current(1).frames[1].location);
    print("messgage: " + o.toString());
    return true;
  }());
}