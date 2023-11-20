import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/common/routes.dart';
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text(
                currentuser != null
                    ? 'Welcome! ' + (currentuser.username ?? '')
                    : '',
              ),
            ),
          ),
          Container(
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.loginScreen);
                  Provider.of<Auth>(context, listen: false).logout();
                },
                child: Text('Logout'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
