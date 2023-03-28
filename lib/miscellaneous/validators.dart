String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter your email address';
  } else if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value)) {
    return 'please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter your password';
  } else if (!RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})')
      .hasMatch(value)) {
    return 'password must be 8 characters or more and contain at least one uppercase, one lowercase and one digit with at least one special character.';
  }
  return null;
}

String? validateEmptyTitle(String? value) {
  if (value == null) {
    return 'Please enter title!';
  }
  return null;
}

String? validateEmptyMessage(String? value) {
  if (value == null) {
    return 'Please enter a message!';
  }
  return null;
}
