import 'dart:convert';

//import 'package:xnote/Views/XIcon.dart';

XNoteItem clientFromJson(String str) {
  final jsonData = json.decode(str);
  return XNoteItem.fromMap(jsonData);
}

String clientToJson(XNoteItem data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class XNoteItem {
  int id;
  String summary;
  String description;
  bool blocked;
  int idTarget;
  int idUser;
  int xNoteType;
  int createDate;
  int startDatePlan;
  int endDatePlan;
  int startDateActual;
  int endDateActual;
  String unitCost;
  int costEstimate;
  int costRemain;
  int costUsed;
  int idUserOwner;
  int idUserAssign;
  int level;
  int subNoteCount;
  String csvSubNoteList;
  int status;

  XNoteItem({
    this.id,
    this.summary,
    this.description,
    this.blocked,
    this.idTarget,
    this.idUser,
    this.xNoteType,
    this.createDate,
    this.startDatePlan,
    this.endDatePlan,
    this.startDateActual,
    this.endDateActual,
    this.unitCost,
    this.costEstimate,
    this.costRemain,
    this.costUsed,
    this.idUserOwner,
    this.idUserAssign,
    this.level,
    this.subNoteCount,
    this.csvSubNoteList,
    this.status,
  });
  XNoteItem clone(){
    return XNoteItem.fromMap( this.toMap());
  }

  factory XNoteItem.fromMap(Map<String, dynamic> json) => new XNoteItem(
    id: json["id"],
    summary: json["summary"],
    description: json["description"],
    blocked: json["blocked"] == 1,
    idTarget: json["idTarget"] == null ? null : json["idTarget"],
    idUser: json["idUser"] == null ? null : json["idUser"],
    xNoteType: json["xNoteType"] == null ? null : json["xNoteType"],
    createDate: json["createDate"] == null ? null : json["createDate"],
    startDatePlan: json["startDatePlan"] == null ? null : json["startDatePlan"],
    endDatePlan: json["endDatePlan"] == null ? null : json["endDatePlan"],
    startDateActual: json["startDateActual"] == null ? null : json["startDateActual"],
    endDateActual: json["endDateActual"] == null ? null : json["endDateActual"],
    unitCost: json["unitCost"] == null ? null : json["unitCost"],
    costEstimate: json["costEstimate"] == null ? null : json["costEstimate"],
    costRemain: json["costRemain"] == null ? null : json["costRemain"],
    costUsed: json["costUsed"] == null ? null : json["costUsed"],
    idUserOwner: json["idUserOwner"] == null ? null : json["idUserOwner"],
    idUserAssign: json["idUserAssign"] == null ? null : json["idUserAssign"],
    level: json["level"] == null ? null : json["level"],
    subNoteCount: json["subNoteCount"] == null ? null : json["subNoteCount"],
    csvSubNoteList: json["csvSubNoteList"] == null ? null : json["csvSubNoteList"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "summary": summary,
    "description": description,
    "blocked": blocked,
    "idTarget": idTarget == null ? null : idTarget,
    "idUser": idUser == null ? null : idUser,
    "xNoteType": xNoteType == null ? null : xNoteType,
    "createDate": createDate == null ? null : createDate,
    "startDatePlan": startDatePlan == null ? null : startDatePlan,
    "endDatePlan": endDatePlan == null ? null : endDatePlan,
    "startDateActual": startDateActual == null ? null : startDateActual,
    "endDateActual": endDateActual == null ? null : endDateActual,
    "unitCost": unitCost == null ? null : unitCost,
    "costEstimate": costEstimate == null ? null : costEstimate,
    "costRemain": costRemain == null ? null : costRemain,
    "costUsed": costUsed == null ? null : costUsed,
    "idUserOwner": idUserOwner == null ? null : idUserOwner,
    "idUserAssign": idUserAssign == null ? null : idUserAssign,
    "level": level == null ? null : level,
    "subNoteCount": subNoteCount == null ? null : subNoteCount,
    "csvSubNoteList": csvSubNoteList == null ? null : csvSubNoteList,
    "status": status == null ? null : status,
  };
}