import 'package:flutter/material.dart';

import '../form/form_text_field.dart';

class LdpCreditDetailForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    int numOfDelayedPayment,
  ) setNumOfDelayedPaymentFn;
  final void Function(
    double changedCreditLimit,
  ) setChangedCreditLimitFn;
  final void Function(
    int numOfCreditInquiries,
  ) setNumOfCreditInquiriesFn;
  final void Function(
    int creditMix,
  ) setCreditMixFn;
  final void Function(
    double creditUtilizationRatio,
  ) setCreditUtilizationRatioFn;
  final void Function(
    int creditHistoryAge,
  ) setCreditHistoryAgeFn;
  final void Function(
    double monthlyBalance,
  ) setMonthlyBalanceFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;

  LdpCreditDetailForm(
    this.formKey,
    this.setNumOfDelayedPaymentFn,
    this.setChangedCreditLimitFn,
    this.setNumOfCreditInquiriesFn,
    this.setCreditMixFn,
    this.setCreditUtilizationRatioFn,
    this.setCreditHistoryAgeFn,
    this.setMonthlyBalanceFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  State<LdpCreditDetailForm> createState() => _LdpCreditDetailFormState();
}

class _LdpCreditDetailFormState extends State<LdpCreditDetailForm> {
  @override
  Widget build(BuildContext context) {
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
                fieldLabel: 'Number of Delayed Payment',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  widget.setNumOfDelayedPaymentFn(int.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Changed Credit Limit',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  widget.setChangedCreditLimitFn(double.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Numer of Credit Inquiries',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  widget.setNumOfCreditInquiriesFn(int.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Credit Mix',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (value) {},
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  int valueEx = int.parse(value);
                  widget.setCreditMixFn(valueEx);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Credit Utilization Ratio',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  widget.setCreditUtilizationRatioFn(double.parse(value));
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Credit History Age',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (value) {},
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  int valueEx = int.parse(value);
                  widget.setCreditHistoryAgeFn(valueEx);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Monthly Balance',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  // FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                validatorFn: (value) {
                  return null;
                },
                onSaveFn: (value) {
                  widget.setMonthlyBalanceFn(double.parse(value));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
