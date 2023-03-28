class Note {
  String? title;
  String? message;
  String? useremail;

  Note({
    this.title,
    this.message,
    this.useremail,
  });

  Map<String, Object?> toJson() => {
        'title': title,
        'message': message,
        'useremail': useremail,
      };

  static Note fromJson(Map<dynamic, dynamic>? json) => Note(
        title: json!['title'],
        message: json['message'],
        useremail: json['useremail'],
      );
}

List<Note> convertToList(Map<dynamic, dynamic> map) {
  List<Note> notes = [];
  for (var i = 0; i < map.length; i++) {
    notes.add(Note.fromJson(map['$i']));
  }
  return notes;
}

Map<dynamic, dynamic> convertToMap(List<Note> notes) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < notes.length; i++) {
    map.addAll({'$i': notes[i].toJson()});
  }
  return map;
}
