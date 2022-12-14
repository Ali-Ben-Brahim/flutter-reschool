import 'package:flutter/material.dart';

import '../constans.dart';

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    
    this.percentage,
  }) : super(key: key);

  final Color? color;
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    
    return 
    Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all( Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage??0 / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all( Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
