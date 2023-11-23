import 'package:flutter/material.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/utility.dart';

class LdpInformationScreen extends StatefulWidget {
  const LdpInformationScreen({Key key}) : super(key: key);

  @override
  State<LdpInformationScreen> createState() => _LdpInformationScreenState();
}

class _LdpInformationScreenState extends State<LdpInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Utility.buildDrawer(context),
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Loan Defualt Prediction',
        ),
      ),
      body: Container(),
    );
  }
}
