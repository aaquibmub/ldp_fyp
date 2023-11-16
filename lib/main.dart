import 'package:flutter/material.dart';
import 'package:ldp_fyp/helpers/common/constants.dart';
import 'package:ldp_fyp/helpers/common/routes.dart';
import 'package:ldp_fyp/providers/auth.dart';
import 'package:ldp_fyp/providers/loan_provider.dart';
import 'package:ldp_fyp/screens/history_screen.dart';
import 'package:ldp_fyp/screens/home_screen.dart';
import 'package:ldp_fyp/screens/login_screen.dart';
import 'package:ldp_fyp/screens/register_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) {
            return Auth();
          },
        ),
        ChangeNotifierProxyProvider<Auth, LoanProvider>(
          update: (ctx, auth, _) {
            return LoanProvider(auth.currentUser);
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, child) => MaterialApp(
          title: 'Loan Default Predictor',
          theme: ThemeData(
              primaryColor: Constants.primaryColor,
              fontFamily: Constants.fontFamilyMontserrat,
              primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                    labelLarge: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
              inputDecorationTheme:
                  Theme.of(context).inputDecorationTheme.copyWith(
                        hintStyle: const TextStyle(
                          color: Constants.textFieldHintColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
              textTheme: Theme.of(context).textTheme.copyWith(
                    displayLarge: const TextStyle(
                      fontSize: 62,
                      fontWeight: FontWeight.w300,
                      color: Constants.primaryColor,
                    ),
                    displayMedium: const TextStyle(
                      fontSize: 62,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                    ),
                    displaySmall: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                    ),
                    headlineMedium: const TextStyle(
                      fontSize: 32,
                      color: Constants.textColor,
                    ),
                    bodyLarge: const TextStyle(
                      fontSize: 18,
                      color: Constants.textColor,
                    ),
                  ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme.of(context).copyWith(
                backgroundColor: Constants.primaryColor,
              )),
          home: authData.isAuth ? HomeScreen() : RegisterScreen(),
          routes: {
            Routes.registerScreen: (ctx) => RegisterScreen(),
            Routes.loginScreen: (ctx) => const LoginScreen(),
            Routes.homeScreen: (ctx) => HomeScreen(),
            Routes.historyScreen: (ctx) => const HistoryScreen(),
          },
        ),
      ),
    );
  }
}
