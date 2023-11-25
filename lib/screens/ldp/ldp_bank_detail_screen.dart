import 'package:flutter/material.dart';
import 'package:ldp_fyp/helpers/models/common/dropdown_item.dart';
import 'package:ldp_fyp/screens/ldp/ldp_complete_screen.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/utility.dart';
import '../../helpers/models/ldp/ldp_bank_detail_model.dart';
import '../../providers/loan_provider.dart';
import '../../widgets/ldp/ldp_bank_detail_form.dart';
import '../loading_screen.dart';

class LdpBankDetailScreen extends StatefulWidget {
  final int pid;
  const LdpBankDetailScreen(
    this.pid, {
    Key key,
  }) : super(key: key);

  @override
  State<LdpBankDetailScreen> createState() => _LdpBankDetailScreenState();
}

class _LdpBankDetailScreenState extends State<LdpBankDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  int _numOfBankAccounts;
  int _numOfCreditCards;
  double _intrestRate;
  int _numOfLoans;
  List<DropdownItem<int>> _typesOfLoan;

  void _setNumOfBankAccounts(
    int numOfBankAccounts,
  ) {
    _numOfBankAccounts = numOfBankAccounts;
  }

  void _setNumOfCreditCards(
    int numOfCreditCards,
  ) {
    _numOfCreditCards = numOfCreditCards;
  }

  void _setIntrestRate(
    double intrestRate,
  ) {
    _intrestRate = intrestRate;
  }

  void _setNumOfLoans(
    int numOfLoans,
  ) {
    _numOfLoans = numOfLoans;
  }

  void _setTypesOfLoan(
    List<DropdownItem<int>> typesOfLoan,
  ) {
    _typesOfLoan = typesOfLoan;
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
      ).updatePredictionBankDetails(LdpBankDetailModel(
        widget.pid,
        _numOfBankAccounts,
        _numOfCreditCards,
        _intrestRate,
        _numOfLoans,
        _typesOfLoan,
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
          'Proceed',
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
                                  'Bank and Loan',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                LdpBankDetailForm(
                                  _formKey,
                                  _setNumOfBankAccounts,
                                  _setNumOfCreditCards,
                                  _setTypesOfLoan,
                                  _setIntrestRate,
                                  _setNumOfLoans,
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
