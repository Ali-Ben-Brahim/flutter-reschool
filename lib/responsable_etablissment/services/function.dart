import 'package:flutter/material.dart';

Color check(dynamic percent) {

    if (percent < 25.0) {
      return Colors.green;
    } else if (percent < 75.0) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  
}
