import 'package:flutter/material.dart';

import '../helpers/models/user.dart';

class LoanProvider with ChangeNotifier {
  final User user;

  LoanProvider(
    this.user,
  );
}
