import 'package:flutter/material.dart';

import '../helpers/common/constants.dart';
import '../helpers/common/utility.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Utility.buildDrawer(context),
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'History',
        ),
      ),
      body: Container(),
    );
  }
}
