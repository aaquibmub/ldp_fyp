import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/models/common/dropdown_item.dart';
import '../../providers/loan_provider.dart';
import '../form/form_text_field.dart';

class LdpBankDetailForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    int numOfBankAccounts,
  ) setNumOfBankAccountFn;
  final void Function(
    int numOfCreditCards,
  ) setNumOfCreditCardsFn;
  final void Function(
    List<DropdownItem<int>> typesOfLoan,
  ) setTypesOfLoanFn;
  final void Function(
    double intrestRate,
  ) setIntrestRateFn;
  final void Function(
    int numOfLoans,
  ) setNumOfLoanFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;

  LdpBankDetailForm(
    this.formKey,
    this.setNumOfBankAccountFn,
    this.setNumOfCreditCardsFn,
    this.setTypesOfLoanFn,
    this.setIntrestRateFn,
    this.setNumOfLoanFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<LdpBankDetailForm> createState() => _LdpBankDetailFormState();
}

class _LdpBankDetailFormState extends State<LdpBankDetailForm> {
  int numberOfLoans;
  List<DropdownItem<int>> _selectedTypeOfLoans = [];

  @override
  Widget build(BuildContext context) {
    Provider.of<LoanProvider>(
      context,
      listen: false,
    ).getTypeOfLoanDropDownList();

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FormTextField(
                fieldLabel: 'Number of Bank Accounts',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  widget.setNumOfBankAccountFn(int.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Number of Credit Cards',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  widget.setNumOfCreditCardsFn(int.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Intrest Rate (%)',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  widget.setIntrestRateFn(double.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Number of Loans',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (value) {
                  int valueEx = int.parse(value);
                  setState(() {
                    numberOfLoans = valueEx;
                    _selectedTypeOfLoans = [];
                    for (var i = 0; i < valueEx; i++) {
                      _selectedTypeOfLoans.add(DropdownItem(null, ''));
                    }
                  });
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  int valueEx = int.parse(value);
                  widget.setNumOfLoanFn(valueEx);
                },
              ),
              SizedBox(
                height: 30,
              ),
              if (numberOfLoans != null && numberOfLoans > 0)
                for (int i = 0; i < numberOfLoans; i++)
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Type of Loan $i',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Container(
                          width: double.infinity,
                          child: Consumer<LoanProvider>(
                              builder: (ctx, provider, _) {
                            return DropdownButton<int>(
                              isExpanded: true,
                              value: _selectedTypeOfLoans[i]?.value,
                              elevation: 16,
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              onChanged: (int value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  final item = provider.typeOfLoanList
                                      .where(
                                          (element) => element.value == value)
                                      .first;
                                  if (item != null) {
                                    String text = item.text;
                                    _selectedTypeOfLoans[i] = DropdownItem(
                                      value,
                                      text,
                                    );
                                    widget.setTypesOfLoanFn(
                                      _selectedTypeOfLoans,
                                    );
                                  }
                                });
                              },
                              selectedItemBuilder: (BuildContext context) {
                                return provider.typeOfLoanList
                                    .map<Widget>((DropdownItem<int> item) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    width: double.infinity,
                                    constraints: const BoxConstraints(
                                      maxWidth: double.infinity,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        item.text,
                                        style: const TextStyle(
                                          color: Constants.backgroundColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              icon: Container(
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                ),
                              ),
                              items: provider.typeOfLoanList
                                  .map<DropdownMenuItem<int>>(
                                      (DropdownItem<int> value) {
                                return DropdownMenuItem<int>(
                                  value: value.value,
                                  child: Text(value.text),
                                );
                              }).toList(),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
