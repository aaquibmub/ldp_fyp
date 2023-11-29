import 'package:flutter/material.dart';
import 'package:ldp_fyp/screens/ldp/ldp_complete_screen.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/utility.dart';
import '../../helpers/models/ldp/ldp_credit_detail_model.dart';
import '../../providers/loan_provider.dart';
import '../../widgets/ldp/ldp_credit_detail_form.dart';
import '../loading_screen.dart';

class LdpCreditDetailScreen extends StatefulWidget {
  final int pid;
  const LdpCreditDetailScreen(this.pid, {Key key}) : super(key: key);

  @override
  State<LdpCreditDetailScreen> createState() => _LdpCreditDetailScreenState();
}

class _LdpCreditDetailScreenState extends State<LdpCreditDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  int _numOfDelayedPayment;
  double _changedCreditLimit;
  int _numOfCreditInquiries;
  int _creditMix;
  double _creditUtilizationRatio;
  int _creditHistoryAge;
  double _monthlyBalance;

  void _setNumOfDelayedPayments(
    int numOfDelayedPayment,
  ) {
    _numOfDelayedPayment = numOfDelayedPayment;
  }

  void _setChangedCreditLimit(
    double changedCreditLimit,
  ) {
    _changedCreditLimit = changedCreditLimit;
  }

  void _setNumOfCreditInquiries(
    int numOfCreditInquiries,
  ) {
    _numOfCreditInquiries = numOfCreditInquiries;
  }

  void _setCreditMix(
    int creditMix,
  ) {
    _creditMix = creditMix;
  }

  void _setCreditUtilizationRatio(
    double creditUtilizationRatio,
  ) {
    _creditUtilizationRatio = creditUtilizationRatio;
  }

  void _setCreditHistoryAge(
    int creditHistoryAge,
  ) {
    _creditHistoryAge = creditHistoryAge;
  }

  void _setMonthlyBalance(
    double monthlyBalance,
  ) {
    _monthlyBalance = monthlyBalance;
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
      var response = await Provider.of<LoanProvider>(
        context,
        listen: false,
      ).updatePredictionCreditDetails(LdpCreditDetailModel(
        widget.pid,
        _numOfDelayedPayment,
        _changedCreditLimit,
        _numOfCreditInquiries,
        _creditMix,
        _creditUtilizationRatio,
        _creditHistoryAge,
        _monthlyBalance,
      ));

      setState(() {
        _isLoading = false;
      });

      if (response.hasError) {
        _showErrorDialogue(context, response.msg);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LdpCompleteScreen(
              widget.pid,
            ),
          ),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      const errorMessage = 'Could not update';
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildSubmitButton() {
      return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).backgroundColor)),
        onPressed: () => _submit(context),
        child: Text(
          'Complete',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      drawer: Utility.buildDrawer(context),
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Loan Defualt Prediction',
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
                                  'Credit Details',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                LdpCreditDetailForm(
                                  _formKey,
                                  _setNumOfDelayedPayments,
                                  _setChangedCreditLimit,
                                  _setNumOfCreditInquiries,
                                  _setCreditMix,
                                  _setCreditUtilizationRatio,
                                  _setCreditHistoryAge,
                                  _setMonthlyBalance,
                                  _submit,
                                  context,
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
