import 'package:flutter/material.dart';

import './form/form_text_field.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(
    String userName,
  ) setUserNameFn;
  final void Function(
    String email,
  ) setEmailFn;
  final void Function(
    String password,
  ) setPasswordFn;
  final void Function(
    String confirmPassword,
  ) setConfirmPasswordFn;
  final void Function(
    BuildContext context,
  ) submitFormFn;
  final BuildContext parentContext;
  RegisterForm(
    this.formKey,
    this.setUserNameFn,
    this.setEmailFn,
    this.setPasswordFn,
    this.setConfirmPasswordFn,
    this.submitFormFn,
    this.parentContext,
  );

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _confirmPasswordFocusNode = FocusNode();
  final _confirmPasswordController = TextEditingController();

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
            children: <Widget>[
              FormTextField(
                fieldLabel: 'Username',
                hintLabel: 'Type user name',
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'User name is required';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                onSaveFn: (value) {
                  widget.setUserNameFn(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Email',
                hintLabel: 'Type email',
                controller: _emailController,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                validatorFn: (value) {
                  if (value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaveFn: (value) {
                  widget.setEmailFn(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Password',
                hintLabel: 'Type password',
                obscureText: true,
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                focusNode: _passwordFocusNode,
                onFieldSubmittedFn: (_) {
                  FocusScope.of(context)
                      .requestFocus(_confirmPasswordFocusNode);
                },
                validatorFn: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaveFn: (value) {
                  widget.setPasswordFn(value);
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                fieldLabel: 'Confirm Password',
                hintLabel: 'Renter password',
                obscureText: true,
                controller: _confirmPasswordController,
                textInputAction: TextInputAction.done,
                focusNode: _confirmPasswordFocusNode,
                onFieldSubmittedFn: (_) {
                  widget.submitFormFn(widget.parentContext);
                },
                validatorFn: (value) {
                  if (_passwordController.text != value) {
                    return 'Password is not matched!';
                  }
                  return null;
                },
                onSaveFn: (value) {
                  widget.setConfirmPasswordFn(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
