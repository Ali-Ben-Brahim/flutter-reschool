import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constans.dart';

class BoxGrid extends StatefulWidget {
  String image;
  double? pourcentage;
  double? somme;
  int? nbr;
  BoxGrid({
    Key? key,
    required this.image,
    required this.pourcentage,
    required this.somme,
    required this.nbr,
  }) : super(key: key);

  @override
  State<BoxGrid> createState() => _BoxGridState();
}

class _BoxGridState extends State<BoxGrid> {
  @override
  Widget build(BuildContext context) {
    return
     SafeArea(
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset(
                      "assets/images/${widget.image}.png",
                    ),
                  ),
                ),
                Flexible(child: Text("(${widget.nbr} P)"))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.image,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            Expanded(
              child: LinearPercentIndicator(
                lineHeight: 8.0,
                percent: widget.pourcentage == null
                    ? 0
                    : (widget.pourcentage! / 100),
                progressColor: (widget.pourcentage ?? 0) < 25
                    ? Colors.green
                    : (widget.pourcentage ?? 0) < 75
                        ? Colors.yellow
                        : Colors.red,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "${widget.somme} Kg",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: const Color.fromARGB(179, 86, 86, 86)),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${widget.pourcentage} %",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: const Color.fromARGB(179, 86, 86, 86)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
