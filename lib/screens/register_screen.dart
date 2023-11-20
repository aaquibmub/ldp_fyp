import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/common/routes.dart';
import '../providers/auth.dart';
import '../screens/loading_screen.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  String _userName;
  String _email;
  String _password;
  String _confirmPassword;

  void _setUserName(
    String userName,
  ) {
    _userName = userName;
  }

  void _setEmail(
    String email,
  ) {
    _email = email;
  }

  void _setPassword(
    String password,
  ) {
    _password = password;
  }

  void _setConfirmPassword(
    String confirmPassword,
  ) {
    _confirmPassword = confirmPassword;
  }

  void _showErrorDialogue(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('An error occured'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      var error = await Provider.of<Auth>(
        context,
        listen: false,
      ).register(_userName, _email, _password);

      setState(() {
        _isLoading = false;
      });

      if (error != '') {
        _showErrorDialogue(context, error);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      const errorMessage = 'Could not register';
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildSignupButton() {
      return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor)),
        onPressed: () => _submit(context),
        child: Text(
          'Sign Up',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: _isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  height: deviceSize.height,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Sign up',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                RegisterForm(
                                  _formKey,
                                  _setUserName,
                                  _setEmail,
                                  _setPassword,
                                  _setConfirmPassword,
                                  _submit,
                                  context,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Container(
                                    width: 400,
                                    child: buildSignupButton(),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                Routes.loginScreen);
                                      },
                                      child: Text('Already register? Login'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
