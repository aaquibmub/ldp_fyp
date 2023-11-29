import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/common/constants.dart';
import '../helpers/common/routes.dart';
import '../helpers/common/utility.dart';
import '../helpers/models/user.dart';
import '../providers/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final User currentuser = Provider.of<Auth>(context).currentUser;

    Widget buildContainer(
      BuildContext context,
      Function onTap,
      IconData iconData,
      String label,
    ) {
      return Container(
        height: 150,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Constants.primaryColor,
        ),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Column(
              children: [
                Icon(
                  iconData,
                  size: 80,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      drawer: Utility.buildDrawer(context),
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Home',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            child: Center(
              child: Text(
                currentuser != null
                    ? 'Welcome! ' + (currentuser.username ?? '')
                    : '',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          buildContainer(
            context,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(Routes.ldpInformationScreen);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LdpCompleteScreen(
              //       1,
              //     ),
              //   ),
              // );
            },
            Icons.bar_chart_sharp,
            'Loan Default Prediction',
          ),
          SizedBox(
            height: 40,
          ),
          buildContainer(
            context,
            () {
              Navigator.of(context).pushReplacementNamed(Routes.historyScreen);
            },
            Icons.history,
            'Prediction History',
          )
        ],
      ),
    );
  }
}
