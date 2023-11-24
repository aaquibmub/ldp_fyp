import 'package:flutter/material.dart';
import 'package:ldp_fyp/providers/loan_provider.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/routes.dart';
import '../../helpers/common/utility.dart';
import '../../helpers/models/common/dropdown_item.dart';
import '../../helpers/models/ldp/ldp_information-model.dart';
import '../../widgets/ldp/lpd_information_form.dart';
import '../loading_screen.dart';

class LdpInformationScreen extends StatefulWidget {
  const LdpInformationScreen({Key key}) : super(key: key);

  @override
  State<LdpInformationScreen> createState() => _LdpInformationScreenState();
}

class _LdpInformationScreenState extends State<LdpInformationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  String _name;
  int _age;
  DropdownItem<int> _occupation;
  double _annualIncome;
  double _monthlyInHandSalary;

  void _setName(
    String name,
  ) {
    _name = name;
  }

  void _setAge(
    int age,
  ) {
    _age = age;
  }

  void _setOccupation(
    DropdownItem<int> occupation,
  ) {
    _occupation = occupation;
  }

  void _setAnnualIncome(
    double annualIncome,
  ) {
    _annualIncome = annualIncome;
  }

  void _setMonthlySalary(
    double monthlySalary,
  ) {
    _monthlyInHandSalary = monthlySalary;
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
      ).createPrediction(LdpInformationModel(
        0,
        _name,
        _age,
        _occupation,
        _annualIncome,
        _monthlyInHandSalary,
      ));

      setState(() {
        _isLoading = false;
      });

      if (response.hasError) {
        _showErrorDialogue(context, response.msg);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      const errorMessage = 'Could not add';
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
                                  'Personal Information',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                LdpInformationForm(
                                  _formKey,
                                  _setName,
                                  _setAge,
                                  _setOccupation,
                                  _setAnnualIncome,
                                  _setMonthlySalary,
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
