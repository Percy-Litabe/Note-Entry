import 'package:assignment2_2022/models/note_entry.dart';
import 'package:assignment2_2022/widgets/register_form.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';

import '../models/note.dart';

class NoteViewModel with ChangeNotifier {
  final noteFormKey = GlobalKey<FormState>();

  NoteEntry? _noteEntry;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  void emptyNotes() {
    _notes = [];
    notifyListeners();
  }

  Future<String> getNotes(String username) async {
    String result = 'OK';
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username";

    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('NoteEntry')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = getError(error.toString());
    });

    if (map != null) {
      if (map.isNotEmpty) {
        _noteEntry = NoteEntry.fromJson(map.first);
        _notes = convertToList(_noteEntry!.notes);
        notifyListeners();
      } else {
        emptyNotes();
      }
    } else {
      result = 'NOT OK';
    }
    return result;
  }

  Future<String> saveNoteEntry(String username, bool initiaLoad) async {
    String result = 'OK';
    if (_notes.isEmpty) {
      _noteEntry = NoteEntry(notes: convertToMap(_notes), useremail: username);
    } else {
      _noteEntry!.notes = convertToMap(_notes);
    }

    await Backendless.data
        .of('NoteEntry')
        .save(_noteEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });
    return result;
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void createNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }
}
