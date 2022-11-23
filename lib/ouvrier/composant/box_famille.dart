import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../responsable_etablissment/constans.dart';

class BoxFamille extends StatefulWidget {
  String image;
  double? pourcentage;
  int nbrPoubelle75;

  int? nbr;
  BoxFamille(
      {Key? key,
      required this.image,
      required this.pourcentage,
      required this.nbr,
      required this.nbrPoubelle75})
      : super(key: key);

  @override
  State<BoxFamille> createState() => _BoxFamilleState();
}

class _BoxFamilleState extends State<BoxFamille> {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 218, 211, 211),
          borderRadius:  BorderRadius.all(Radius.circular(10)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: LinearPercentIndicator(
                    lineHeight: 10.0,
                    percent: widget.pourcentage == null
                        ? 0
                        : (widget.pourcentage! / 100),
                    progressColor: (widget.pourcentage ?? 0) <= 25
                        ? Colors.green
                        : (widget.pourcentage ?? 0) < 75
                            ? Colors.yellow
                            : Colors.red,
                  ),
                ),
                Text(
                  "${widget.pourcentage} %",
                  maxLines: 1,
                  style: const TextStyle(color: Color.fromARGB(179, 86, 86, 86)),
                ),
              ],
            ),
            Text(
              "Nbr poubelle > 75% (${widget.nbrPoubelle75})",
              style: TextStyle(
                  color: widget.nbrPoubelle75==0?Colors.black: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
