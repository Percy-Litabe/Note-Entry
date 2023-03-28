import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InitApp {
  static const String apiKeyAndroid =
      '8DE789D1-9CCE-4ACF-87C6-FB8D0C2A4C87'; //add your own key
  static const String apiKeyIOS =
      'C2DFC39D-B338-4294-A3C8-99C772647669'; //add your own key
  static const String appID =
      '8D16C555-968F-F168-FF20-5A2770175700'; // add your own key
  static const String jsApiKey =
      'B9D5BDD2-74FD-4060-9C7E-5964549DE272'; // add your own key
  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID,
        jsApiKey: jsApiKey);
    String result =
        await context.read<UserManagementViewModel>().checkUserLoggedIn();
    if (result == 'OK') {
      locator
          .get<NavigationAndDialogService>()
          .navigateTo(RouteManager.noteListPage);
    } else if (result == 'NOT OK') {
      locator
          .get<NavigationAndDialogService>()
          .navigateTo(RouteManager.registerPage);
    } else {
      locator
          .get<NavigationAndDialogService>()
          .navigateTo(RouteManager.loginPage);
    }
  }
}
