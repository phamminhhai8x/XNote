import 'dart:convert';

NoteItem clientFromJson(String str) {
  final jsonData = json.decode(str);
  return NoteItem.fromMap(jsonData);
}

String clientToJson(NoteItem data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class NoteItem {
  int id;
  String firstName;
  String lastName;
  bool blocked;

  NoteItem({
    this.id,
    this.firstName,
    this.lastName,
    this.blocked,
  });

  factory NoteItem.fromMap(Map<String, dynamic> json) => new NoteItem(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    blocked: json["blocked"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "blocked": blocked,
  };
}