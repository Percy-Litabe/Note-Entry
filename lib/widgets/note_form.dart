// ignore_for_file: use_build_context_synchronously

import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../miscellaneous/constants.dart';
import '../miscellaneous/validators.dart';
import '../view_models/note_view_model.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({
    Key? key,
  }) : super(key: key);

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  late TextEditingController titleController;
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<NoteViewModel>().noteFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'New Note',
              style: headingStyle,
            ),
            const SizedBoxH30(),
            TextFormField(
              validator: validateEmptyTitle,
              controller: titleController,
              decoration: formDecoration('Title', Icons.book),
            ),
            const SizedBoxH10(),
            TextFormField(
              maxLines: 6,
              minLines: 3,
              validator: validateEmptyMessage,
              controller: messageController,
              decoration: formDecoration('Content', Icons.message),
            ),
            const SizedBoxH20(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () async {
                if (titleController.text.isEmpty &&
                    messageController.text.isEmpty) {
                  locator.get<NavigationAndDialogService>().showSnackBar(
                      message: 'Please enter all fields, then press save!',
                      title: 'Error:');
                } else {
                  Note note = Note(
                    title: titleController.text.trim(),
                    message: messageController.text.trim(),
                  );

                  if (context.read<NoteViewModel>().notes.contains(note)) {
                    locator.get<NavigationAndDialogService>().showSnackBar(
                        message:
                            'The value you have just entered seems to be a duplicate. Please enter another value.',
                        title: 'Error:');
                  } else {
                    titleController.text = '';
                    messageController.text = '';
                    context.read<NoteViewModel>().createNote(note);
                  }
                }

                String result = await context
                    .read<NoteViewModel>()
                    .saveNoteEntry(
                        context
                            .read<UserManagementViewModel>()
                            .currentUser!
                            .email,
                        true);
                if (result != 'OK') {
                  locator
                      .get<NavigationAndDialogService>()
                      .showSnackBar(message: result, title: 'Error: ');
                } else {
                  Navigator.of(context).pop();
                  locator.get<NavigationAndDialogService>().showSnackBar(
                      message: 'User successfully registered!',
                      title: context
                          .read<UserManagementViewModel>()
                          .currentUser!
                          .email);
                }
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
