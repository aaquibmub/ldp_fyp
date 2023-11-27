import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/routes.dart';
import '../../providers/loan_provider.dart';
import '../loading_screen.dart';

class LdpCompleteScreen extends StatefulWidget {
  final int pid;
  const LdpCompleteScreen(this.pid, {Key key}) : super(key: key);

  @override
  State<LdpCompleteScreen> createState() => _LdpCompleteScreenState();
}

class _LdpCompleteScreenState extends State<LdpCompleteScreen> {
  bool _isLoading = true;
  double predictionResult = 0;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<LoanProvider>(
      context,
      listen: false,
    )
        .getPredictionResult(
      widget.pid,
    )
        .then((value) {
      setState(() {
        _isLoading = false;
        predictionResult = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildSubmitButton() {
      return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).backgroundColor)),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
        },
        child: Text(
          'Go to Home',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Prediction Result',
        ),
      ),
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
                                  'The percentage that the user might default is',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                Center(
                                  child: Text(
                                    '${predictionResult.toStringAsFixed(2)} %',
                                    style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Container(
                                    width: 400,
                                    child: buildSubmitButton(),
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
