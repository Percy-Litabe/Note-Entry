import 'package:assignment2_2022/models/note_entry.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:assignment2_2022/widgets/register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';

class UserManagementViewModel with ChangeNotifier {
  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  BackendlessUser? _currentUser;
  bool _userExists = false;
  BackendlessUser? get currentUser => _currentUser;
  bool get userExists => _userExists;

  set userExist(bool value) {
    _userExists = value;
    notifyListeners();
  }

  void setCurrentUserToNull() {
    _currentUser = null;
    notifyListeners();
  }

  Future<String> register(BackendlessUser user) async {
    String result = 'OK';

    await Backendless.userService.register(user).then((user) {
      NoteEntry newNote = NoteEntry(
        notes: {},
        useremail: user!.email,
      );
      Backendless.data.of('NoteEntry').save(newNote.toJson()).onError(
        (error, stackTrace) {
          result = error.toString();
          locator.get<NavigationAndDialogService>().showSnackBar(
              message: error.toString(), title: 'Error occured: ');
          return null;
        },
      );
    }).onError((error, stackTrace) {
      result = getError(error.toString());
    });

    return result;
  }

  Future<String> userLogin(String username, String password) async {
    String result = 'OK';

    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      result = getError(error.toString());
      return null;
    });

    if (user != null) {
      _currentUser = user;
    }
    notifyListeners();
    return result;
  }

  Future<String> logout() async {
    String result = 'OK';

    await Backendless.userService.logout().onError((error, stackTrace) {
      result = getError(error.toString());
    });
    return result;
  }

  Future<String> checkUserLoggedIn() async {
    String result = 'OK';

    bool? loginValid = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = getError(error.toString());
    });

    if (loginValid != null && loginValid) {
      String? currentUserID = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });

      if (currentUserID != null) {
        Map<dynamic, dynamic>? currentUserMap = await Backendless.data
            .of("Users")
            .findById(currentUserID)
            .onError((error, stackTrace) {
          result = error.toString();
        });

        if (currentUserMap != null) {
          _currentUser = BackendlessUser.fromJson(currentUserMap);
          notifyListeners();
        } else {
          result = 'NOT OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }

    return result;
  }

  void checkUserExists(String username) async {
    DataQueryBuilder query = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(query)
        .then((value) {
      if (value == null || value.isEmpty) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      locator
          .get<NavigationAndDialogService>()
          .showSnackBar(message: getError(error.toString()), title: 'Error');
    });
  }

  Future<String> resetPassword(String username) async {
    String result = 'OK';
    Backendless.userService.restorePassword(username).then((value) {
      locator.get<NavigationAndDialogService>().showSnackBar(
          message: 'Password restore instructions sent via email',
          title: 'Password Reset:');
    }).onError((error, stackTrace) {
      locator
          .get<NavigationAndDialogService>()
          .showSnackBar(message: getError(error.toString()), title: 'Error:');
    });
    return result;
  }
}
