import 'package:flutter/material.dart';

const TextStyle headingStyle = TextStyle(
  fontSize: 22,
  color: Colors.grey,
);

const TextStyle style14Blue = TextStyle(
  fontSize: 14,
  color: Colors.grey,
);

const TextStyle titleStyle = TextStyle(
  fontSize: 22,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

const focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  borderSide: BorderSide(
    width: 2,
    color: Colors.blue,
  ),
);

const errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  borderSide: BorderSide(
    width: 2,
    color: Colors.deepOrange,
  ),
);

const enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  borderSide: BorderSide(
    width: 1,
    color: Colors.blueGrey,
  ),
);

InputDecoration formDecoration(String labelText, IconData iconData) {
  return InputDecoration(
      errorStyle: const TextStyle(
        fontSize: 10,
      ),
      //counterText: '',
      prefixIcon: Icon(
        iconData,
        color: Colors.blueGrey,
      ),
      errorMaxLines: 3,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.blueGrey),
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder);
}

class SizedBoxH10 extends StatelessWidget {
  const SizedBoxH10({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}

class SizedBoxH20 extends StatelessWidget {
  const SizedBoxH20({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class SizedBoxH30 extends StatelessWidget {
  const SizedBoxH30({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}
