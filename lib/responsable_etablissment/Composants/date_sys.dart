import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class DateSys extends StatefulWidget {
  const DateSys({Key? key, }) : super(key: key);

  

  @override
  _DateSysState createState() => _DateSysState();
}

class _DateSysState extends State<DateSys> {
  late String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text(_timeString));
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if(mounted)
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss dd/MM/yyyy ').format(dateTime);
  }
}