import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ldp_fyp/helpers/common/constants.dart';
import 'package:ldp_fyp/helpers/common/routes.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../models/user.dart';
import 'shared_types.dart';

class Utility {
  static dynamic getValuebyDeviceSize(
      Size deviceSize, dynamic phone, dynamic tablet, dynamic monitor) {
    return deviceSize.width < Constants.deviceTypePhoneMaxWidth
        ? phone
        : deviceSize.width < Constants.deviceTypeTabletMaxWidth
            ? tablet
            : monitor;
  }

  static DeviceType getDeviceType(Size deviceSize) {
    return deviceSize.width < Constants.deviceTypePhoneMaxWidth
        ? DeviceType.phone
        : deviceSize.width < Constants.deviceTypeTabletMaxWidth
            ? DeviceType.tablet
            : DeviceType.monitor;
  }

  static bool isPhone(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.phone;
  }

  static bool isTablet(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.tablet;
  }

  static bool isMonitor(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.monitor;
  }

  static double getPercentageValue(double maxValue, double percentage) {
    return ((percentage / 100) * maxValue);
  }

  static String convertBase64StringToJsonString(String base64String) {
    return utf8.decode(base64.decode(base64String));
  }

  static String convertStringToBase64String(String str) {
    return base64.encode(utf8.encode(str));
  }

  static void toBeImplemented(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Work in progress'),
            content: const Text('To be implemented'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay'))
            ],
          );
        });
  }

  static void errorAlert(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title ?? "ERROR!"),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay'))
            ],
          );
        });
  }

  static Drawer buildDrawer(BuildContext context) {
    final User currentuser = Provider.of<Auth>(context).currentUser;

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Constants.primaryColor,
            ),
            child: Text(
              'Hello, ${(currentuser != null ? currentuser.userName : ' ')}',
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.homeScreen,
              );
            },
          ),
          ListTile(
            title: const Text('History'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.historyScreen);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
              Provider.of<Auth>(
                context,
                listen: false,
              ).logout();
            },
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
  }
}
