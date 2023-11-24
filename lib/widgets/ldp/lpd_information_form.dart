import 'package:flutter/material.dart';
import 'package:ldp_fyp/helpers/common/constants.dart';
import 'package:ldp_fyp/helpers/models/common/dropdown_item.dart';
import 'package:provider/provider.dart';

import '../../providers/loan_provider.dart';
import '../form/form_text_field.dart';

class LdpInformationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    String name,
  ) setNameFn;
  final void Function(
    int age,
  ) setAgeFn;
  final void Function(
    DropdownItem<int> occupation,
  ) setOccupationFn;
  final void Function(
    double annualIncome,
  ) setAnnualIncomeFn;
  final void Function(
    double monthlyInHandSalary,
  ) setMonthlyInHandSalaryFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;

  LdpInformationForm(
    this.formKey,
    this.setNameFn,
    this.setAgeFn,
    this.setOccupationFn,
    this.setAnnualIncomeFn,
    this.setMonthlyInHandSalaryFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<LdpInformationForm> createState() => _LdpInformationFormState();
}

class _LdpInformationFormState extends State<LdpInformationForm> {
  DropdownItem<int> _selectedOccupation;

  @override
  Widget build(BuildContext context) {
    Provider.of<LoanProvider>(
      context,
      listen: false,
    ).getOccupationDropDownList();

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
                fieldLabel: 'Name',
                hintLabel: 'Type name',
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                onSaveFn: (value) {
                  widget.setNameFn(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Occupation',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                width: double.infinity,
                child: Consumer<LoanProvider>(builder: (ctx, provider, _) {
                  return DropdownButton<int>(
                    isExpanded: true,
                    value: _selectedOccupation?.value,
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
                        final item = provider.occupationList
                            .where((element) => element.value == value)
                            .first;
                        if (item != null) {
                          String text = item.text;
                          _selectedOccupation = DropdownItem(
                            value,
                            text,
                          );
                          widget.setOccupationFn(
                            _selectedOccupation,
                          );
                        }
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return provider.occupationList
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
                    items: provider.occupationList
                        .map<DropdownMenuItem<int>>((DropdownItem<int> value) {
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
              FormTextField(
                fieldLabel: 'Age',
                keyboardType: TextInputType.number,
                hintLabel: 'Type email',
                // controller: _emailController,
                textInputAction: TextInputAction.next,
                // focusNode: _emailFocusNode,
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Age is required';
                  }
                  return null;
                },
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  widget.setAgeFn(int.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Annual Income',
                hintLabel: 'Type annual income',
                keyboardType: TextInputType.number,
                // controller: _passwordController,
                textInputAction: TextInputAction.next,
                // focusNode: _passwordFocusNode,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context)
                  // .requestFocus(_confirmPasswordFocusNode);
                },
                validatorFn: (value) {
                  if (value.isEmpty || value.length < 4) {
                    return 'Annual income should be more than 1000!';
                  }
                  return null;
                },
                onSaveFn: (value) {
                  widget.setAnnualIncomeFn(double.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Monthly Inhand Salary',
                hintLabel: 'Enter monhtly salary',
                keyboardType: TextInputType.number,
                // controller: _confirmPasswordController,
                textInputAction: TextInputAction.done,
                // focusNode: _confirmPasswordFocusNode,
                onFieldSubmittedFn: (_) {
                  widget.submitFormFn(widget.parentContext);
                },
                validatorFn: (value) {
                  // if (_passwordController.text != value) {
                  //   return 'Password is not matched!';
                  // }
                  return null;
                },
                onSaveFn: (value) {
                  widget.setMonthlyInHandSalaryFn(double.parse(value));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
