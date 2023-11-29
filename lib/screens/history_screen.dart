import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ldp_fyp/helpers/models/ldp/ldp_history_list_model.dart';
import 'package:ldp_fyp/screens/loading_screen.dart';
import 'package:provider/provider.dart';

import '../helpers/common/constants.dart';
import '../helpers/common/utility.dart';
import '../providers/loan_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = true;
  List<LdpHistoryListModel> list = [];

  @override
  void initState() {
    _isLoading = true;
    Provider.of<LoanProvider>(
      context,
      listen: false,
    ).getPredictionHistoryList().then((value) {
      setState(() {
        _isLoading = false;
        list = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Utility.buildDrawer(context),
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text(
          'History',
        ),
      ),
      body: _isLoading
          ? LoadingScreen()
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (_a, i) {
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                  ),
                  child: Column(children: [
                    Text(list[i].name),
                    Text(list[i].date != null
                        ? DateFormat('yyyy-MM-dd – kk:mm').format(list[i].date)
                        : ''),
                    Text(
                      list[i].score == 1 ? 'Will Default' : 'Not Default',
                    ),
                  ]),
                );
              },
            ),
    );
  }
}
