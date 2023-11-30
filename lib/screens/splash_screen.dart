import 'package:flutter/material.dart';

import '../helpers/common/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Center(
        child: Text('loading..'),
      ),
    );
  }
}
