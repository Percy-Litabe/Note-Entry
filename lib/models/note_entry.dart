class NoteEntry {
  Map<dynamic, dynamic> notes;
  String useremail;
  DateTime? created;

  NoteEntry({
    required this.notes,
    required this.useremail,
    this.created,
  });

  Map<String, Object?> toJson() => {
        'notes': notes,
        'usermail': useremail,
        'created': created,
      };

  static NoteEntry fromJson(Map<dynamic, dynamic>? json) => NoteEntry(
        notes: json!['notes'] as Map<dynamic, dynamic>,
        useremail: json['useremail'] as String,
        created: json['created'] as DateTime,
      );
}
