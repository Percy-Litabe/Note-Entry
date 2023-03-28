import 'package:flutter/material.dart';
import '../init.dart';
import '../widgets/app_progress_indicator.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    InitApp.initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.deepOrange, Colors.blueGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        )),
        child: Stack(
          alignment: Alignment.topCenter,
          children: const [
            Text(
              'Welcome to TakeNote!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            // SizedBoxH30(),
            AppProgressIndicator(
                text: 'Busy checking credentials...please wait...'),
          ],
        ),
      ),
    );
  }
}
