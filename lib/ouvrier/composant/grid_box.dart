import 'package:estionnaire/ouvrier/composant/box_famille.dart';
import 'package:flutter/material.dart';

import '../pages/data_table_famille.dart';

class GridBox extends StatefulWidget {
  int nbrPlastique;
  int nbrPapier;
  int nbrComposte;
  int nbrCanette;
  int nbrPlastique75;
  int nbrPapier75;
  int nbrComposte75;
  int nbrCanette75;
  double moyenPlastique;
  double moyenPapier;
  double moyenComposte;
  double moyenCanette;
  int id;

  GridBox(
      {Key? key,
      required this.nbrPlastique,
      required this.nbrCanette,
      required this.nbrComposte,
      required this.nbrPapier,
      required this.nbrPlastique75,
      required this.nbrCanette75,
      required this.nbrComposte75,
      required this.nbrPapier75,
      required this.moyenPlastique,
      required this.moyenCanette,
      required this.moyenComposte,
      required this.moyenPapier,
      required this.id})
      : super(key: key);

  @override
  State<GridBox> createState() => _GridBoxState();
}

class _GridBoxState extends State<GridBox> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SafeArea(
          child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: const EdgeInsets.all(20),
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DataFamille(
                          type: "plastique",
                          id: widget.id,
                        )),
              );
            },
            child: BoxFamille(
              nbrPoubelle75: widget.nbrPlastique75,
              image: "plastique",
              nbr: widget.nbrPlastique == null ? 0 : widget.nbrPlastique,
              pourcentage:
                  widget.moyenPlastique == null ? 0 : widget.moyenPlastique,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DataFamille(
                          type: "canette",
                          id: widget.id,
                        )),
              );
            },
            child: BoxFamille(
              image: "canette",
              nbrPoubelle75: widget.nbrCanette75,
              nbr: widget.nbrCanette == null ? 0 : widget.nbrCanette,
              pourcentage:
                  widget.moyenCanette == null ? 0 : widget.moyenCanette,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DataFamille(
                          type: "papier",
                          id: widget.id,
                        )),
              );
            },
            child: BoxFamille(
              nbrPoubelle75: widget.nbrPapier75,
              image: "papier",
              nbr: widget.nbrPapier == null ? 0 : widget.nbrPapier,
              pourcentage: widget.moyenPapier == null ? 0 : widget.moyenPapier,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DataFamille(
                          type: "composte",
                          id: widget.id,
                        )),
              );
            },
            child: BoxFamille(
              nbrPoubelle75: widget.nbrComposte75,
              image: "composte",
              nbr: widget.nbrComposte == null ? 0 : widget.nbrComposte,
              pourcentage:
                  widget.moyenComposte == null ? 0 : widget.moyenComposte,
            ),
          ),
        ],
      )),
    );
  }
}
