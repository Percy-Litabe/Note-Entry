import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../miscellaneous/constants.dart';
import '../miscellaneous/validators.dart';
import '../view_models/user_management_view_model.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController retypePasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    retypePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UserManagementViewModel>().registerFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          widthFactor: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Register a new User',
                style: headingStyle,
              ),
              const SizedBoxH30(),
              TextFormField(
                validator: validateEmail,
                controller: emailController,
                decoration: formDecoration('Email', Icons.mail),
              ),
              const SizedBoxH10(),
              TextFormField(
                validator: validatePassword,
                controller: passwordController,
                decoration: formDecoration('Password', Icons.lock),
              ),
              const SizedBoxH10(),
              TextFormField(
                validator: validatePassword,
                controller: retypePasswordController,
                decoration: formDecoration('Re-Type Password', Icons.lock),
              ),
              const SizedBoxH20(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () async {
                  BackendlessUser buser = BackendlessUser()
                    ..email = emailController.text.trim()
                    ..password = passwordController.text.trim()
                    ..putProperties({
                      'notes': {},
                    });

                  String result = await context
                      .read<UserManagementViewModel>()
                      .register(buser);
                  if (result != 'OK') {
                    locator.get<NavigationAndDialogService>().showSnackBar(
                        title: 'Something went wrong:',
                        message: getError(result.toString()));
                  } else {
                    locator
                        .get<NavigationAndDialogService>()
                        .popAndNavigateTo(RouteManager.loginPage);

                    locator.get<NavigationAndDialogService>().showSnackBar(
                          title: buser.email,
                          message: 'User successfully registered!',
                        );
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getError(String error) {
  if (error.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again.';
  }

  if (error.contains('user already exists')) {
    return 'This user already exists in the database. Please create a new user.';
  }

  if (error.contains('Invalid login or password')) {
    return 'Please check user email and password. Combination does not exist in our database.';
  }

  if (error
      .contains('User account is locked out due to too many failed logins')) {
    return 'Your account is locked due to too many failed login attempts. Please wait 10min and try again.';
  }

  if (error.contains('Unable to find a user with the specified identity')) {
    return 'Your email address does not match any account in our database. Please check if there isnt any typo.';
  }

  if (error.contains(
      'unable to resolve host "api.backendless.com": no address associated with hostname')) {
    return 'It seems as if you don not have an internet connection. Please reconnect and try again.';
  }
  return error;
}
