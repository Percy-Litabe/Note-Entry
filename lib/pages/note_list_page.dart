import 'package:assignment2_2022/view_models/note_view_model.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/route_manager.dart';
import '../services/locator_service.dart';
import '../services/navigation_and_dialog_service.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.read<UserManagementViewModel>().logout();
                locator
                    .get<NavigationAndDialogService>()
                    .popAndNavigateTo(RouteManager.loginPage);
              },
              icon: const Icon(Icons.lock),
            ),
            IconButton(
                onPressed: () async {
                  String result = await context.read<NoteViewModel>().getNotes(
                      context
                          .read<UserManagementViewModel>()
                          .currentUser!
                          .email);

                  if (result != 'OK') {
                    locator
                        .get<NavigationAndDialogService>()
                        .showSnackBar(message: result, title: 'Error:');
                  } else {
                    locator.get<NavigationAndDialogService>().showSnackBar(
                        message: 'Data successfully refreshed',
                        title: 'Refreshed');
                  }
                },
                icon: const Icon(Icons.refresh)),
            IconButton(
              onPressed: () {
                locator
                    .get<NavigationAndDialogService>()
                    .navigateTo(RouteManager.noteCreatePage);
              },
              icon: const Icon(Icons.add),
            ),
          ],
          automaticallyImplyLeading: false,
          title: const Text('List of Notes'),
        ),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              title: const Text('Title'),
            );
          },
        ));
  }
}
