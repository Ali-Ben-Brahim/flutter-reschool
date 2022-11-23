// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../gestionnaire/provider/login_provider.dart';
import '../provider/planning_class.dart';

class Planning extends StatefulWidget {
  const Planning({Key? key}) : super(key: key);

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
   
    if (DateTime.now().day == details.date.day) {
      return Container(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle),
                  child: Text(
                    details.date.day.toString(),
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
    

    if (details.appointments.isNotEmpty) {
      return Container(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DateTime.now().day == details.date.day
                    ? Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                        child: Text(
                          details.date.day.toString(),
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Text(
                        details.date.day.toString(),
                        textAlign: TextAlign.center,
                      ),
                if (details.date.weekday == 1)
                  Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .lundi![1][0]["statut"] ==
                          "problem"
                      ? Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 20,
                        )
                      : Icon(
                          Icons.hourglass_bottom,
                          color: Colors.orange,
                          size: 20,
                        ),
                if (details.date.weekday == 2)
                  Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .mardi![1][0]["statut"] ==
                          "problem"
                      ? Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 20,
                        )
                      : Icon(
                          Icons.hourglass_bottom,
                          color: Colors.orange,
                          size: 20,
                        ),
                if (details.date.weekday == 3)
                  Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .mercredi![1][0]["statut"] ==
                          "problem"
                      ? Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 20,
                        )
                      : Icon(
                          Icons.hourglass_bottom,
                          color: Colors.orange,
                          size: 20,
                        ),
                if (details.date.weekday == 4)
                  Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .jeudi![1][0]["statut"] ==
                          "problem"
                      ? Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 20,
                        )
                      : Icon(
                          Icons.hourglass_bottom,
                          color: Colors.orange,
                          size: 20,
                        ),
                if (details.date.weekday == 5)
                  Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .vendredi![1][0]["statut"] ==
                          "problem"
                      ? Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 20,
                        )
                      : Icon(
                          Icons.hourglass_bottom,
                          color: Colors.orange,
                          size: 20,
                        ),
                if (details.date.weekday == 6)
                  Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .samedi![1][0]["statut"] ==
                          "problem"
                      ? Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 20,
                        )
                      : Icon(
                          Icons.hourglass_bottom,
                          color: Colors.orange,
                          size: 20,
                        ),
              ],
            )
          ],
        ),
      );
    }
    return Container(
      child: Text(
        details.date.day.toString(),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final postModel = Provider.of<PlanningClass>(context, listen: false);
    postModel.getPostData(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    print(DateFormat.EEEE().format(DateTime.now()).toLowerCase());
    if (DateFormat.EEEE().format(DateTime.now()).toLowerCase() == "monday") {
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .lundi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .lundi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 0,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .lundi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
              '${Provider.of<PlanningClass>(context, listen: false).post!.lundi![1][index]["type_poubelle"]}',
              startTime,
              endTime,
              Provider.of<PlanningClass>(context, listen: false).post!.lundi![1]
                          [index]["type_poubelle"] ==
                      "plastique"
                  ? Colors.blue
                  : Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .lundi![1][index]["type_poubelle"] ==
                          "papier"
                      ? Colors.amber
                      : Provider.of<PlanningClass>(context, listen: false)
                                  .post!
                                  .lundi![1][index]["type_poubelle"] ==
                              "canette"
                          ? Colors.red
                          : Colors.green,
              false));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mardi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mardi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 1,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mardi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
              '${Provider.of<PlanningClass>(context, listen: false).post!.mardi![1][index]["type_poubelle"]}',
              startTime,
              endTime,
              Provider.of<PlanningClass>(context, listen: false).post!.mardi![1]
                          [index]["type_poubelle"] ==
                      "plastique"
                  ? Colors.blue
                  : Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .mardi![1][index]["type_poubelle"] ==
                          "papier"
                      ? Colors.amber
                      : Provider.of<PlanningClass>(context, listen: false)
                                  .post!
                                  .mardi![1][index]["type_poubelle"] ==
                              "canette"
                          ? Colors.red
                          : Colors.green,
              false));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mercredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mercredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 2,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mercredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
              '${Provider.of<PlanningClass>(context, listen: false).post!.mercredi![1][index]["type_poubelle"]}',
              startTime,
              endTime,
              Provider.of<PlanningClass>(context, listen: false)
                          .post!
                          .mercredi![1][index]["type_poubelle"] ==
                      "plastique"
                  ? Colors.blue
                  : Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .mercredi![1][index]["type_poubelle"] ==
                          "papier"
                      ? Colors.amber
                      : Provider.of<PlanningClass>(context, listen: false)
                                  .post!
                                  .mercredi![1][index]["type_poubelle"] ==
                              "canette"
                          ? Colors.red
                          : Colors.green,
              false));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .jeudi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .jeudi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 3,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .jeudi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
              '${Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1][index]["type_poubelle"]}',
              startTime,
              endTime,
              Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1]
                          [index]["type_poubelle"] ==
                      "plastique"
                  ? Colors.blue
                  : Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .jeudi![1][index]["type_poubelle"] ==
                          "papier"
                      ? Colors.amber
                      : Provider.of<PlanningClass>(context, listen: false)
                                  .post!
                                  .jeudi![1][index]["type_poubelle"] ==
                              "canette"
                          ? Colors.red
                          : Colors.green,
              false));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .vendredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .vendredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 4,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .vendredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
              '${Provider.of<PlanningClass>(context, listen: false).post!.vendredi![1][index]["type_poubelle"]}',
              startTime,
              endTime,
              Provider.of<PlanningClass>(context, listen: false)
                          .post!
                          .vendredi![1][index]["type_poubelle"] ==
                      "plastique"
                  ? Colors.blue
                  : Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .vendredi![1][index]["type_poubelle"] ==
                          "papier"
                      ? Colors.amber
                      : Provider.of<PlanningClass>(context, listen: false)
                                  .post!
                                  .vendredi![1][index]["type_poubelle"] ==
                              "canette"
                          ? Colors.red
                          : Colors.green,
              false));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .samedi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .samedi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 5,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .samedi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.samedi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.samedi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .samedi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .samedi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }

      int lundi = 0;
      int mardi = 1;
      int mercredi = 2;
      int jeudi = 3;
      int vendredi = 4;
      int samedi = 5;
    } else if (DateFormat.EEEE().format(DateTime.now()).toLowerCase() ==
        "tuesday") {
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .lundi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .lundi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 6,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .lundi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.lundi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.lundi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .lundi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .lundi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mardi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mardi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 0,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mardi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mardi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.mardi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mardi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mardi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mercredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mercredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 1,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mercredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mercredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .mercredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mercredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mercredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .jeudi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .jeudi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 2,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .jeudi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .jeudi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .jeudi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .vendredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .vendredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 3,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .vendredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.vendredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .vendredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .vendredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .vendredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .samedi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .samedi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 4,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .samedi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.samedi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.samedi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .samedi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .samedi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
    } else if (DateFormat.EEEE().format(DateTime.now()).toLowerCase() ==
        "Wednesday") {
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .lundi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .lundi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 5,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .lundi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.lundi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.lundi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .lundi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .lundi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mardi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mardi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 6,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mardi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mardi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.mardi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mardi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mardi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mercredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mercredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 0,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mercredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mercredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .mercredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mercredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mercredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .jeudi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .jeudi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 1,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .jeudi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .jeudi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .jeudi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .vendredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .vendredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 2,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .vendredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.vendredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .vendredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .vendredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .vendredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .samedi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .samedi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 3,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .samedi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.samedi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.samedi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .samedi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .samedi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
    } else if (DateFormat.EEEE().format(DateTime.now()).toLowerCase() ==
        "thursday") {
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .lundi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .lundi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 4,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .lundi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.lundi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.lundi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .lundi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .lundi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mardi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mardi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 5,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mardi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mardi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.mardi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mardi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mardi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mercredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mercredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 6,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mercredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mercredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .mercredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mercredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mercredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .jeudi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .jeudi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 0,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .jeudi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .jeudi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .jeudi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .vendredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .vendredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 1,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .vendredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.vendredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .vendredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .vendredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .vendredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .samedi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .samedi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 2,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .samedi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.samedi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.samedi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .samedi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .samedi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
    } else if (DateFormat.EEEE().format(DateTime.now()).toLowerCase() ==
        "friday") {
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .lundi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .lundi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 3,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .lundi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.lundi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.lundi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .lundi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .lundi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mardi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mardi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 4,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mardi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mardi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.mardi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mardi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mardi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mercredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mercredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 5,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mercredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mercredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .mercredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mercredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mercredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .jeudi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .jeudi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 6,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .jeudi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .jeudi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .jeudi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .vendredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .vendredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 0,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .vendredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.vendredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .vendredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .vendredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .vendredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .samedi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .samedi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 1,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .samedi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.samedi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.samedi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .samedi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .samedi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
    } else if (DateFormat.EEEE().format(DateTime.now()).toLowerCase() ==
        "saturday") {
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .lundi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .lundi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 2,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .lundi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.lundi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.lundi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .lundi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .lundi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mardi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mardi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 3,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mardi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.mardi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false).post!.mardi![1]
                        [index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .mardi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .mardi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .mercredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .mercredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 4,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .mercredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
              '${Provider.of<PlanningClass>(context, listen: false).post!.mercredi![1][index]["type_poubelle"]}',
              startTime,
              endTime,
              Provider.of<PlanningClass>(context, listen: false)
                          .post!
                          .mercredi![1][index]["type_poubelle"] ==
                      "plastique"
                  ? Colors.blue
                  : Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .mercredi![1][index]["type_poubelle"] ==
                          "papier"
                      ? Colors.amber
                      : Provider.of<PlanningClass>(context, listen: false)
                                  .post!
                                  .mercredi![1][index]["type_poubelle"] ==
                              "canette"
                          ? Colors.red
                          : Colors.green,
              false));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .jeudi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .jeudi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 5,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .jeudi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
              '${Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1][index]["type_poubelle"]}',
              startTime,
              endTime,
              Provider.of<PlanningClass>(context, listen: false).post!.jeudi![1]
                          [index]["type_poubelle"] ==
                      "plastique"
                  ? Colors.blue
                  : Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .jeudi![1][index]["type_poubelle"] ==
                          "papier"
                      ? Colors.amber
                      : Provider.of<PlanningClass>(context, listen: false)
                                  .post!
                                  .jeudi![1][index]["type_poubelle"] ==
                              "canette"
                          ? Colors.red
                          : Colors.green,
              false));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .vendredi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .vendredi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 6,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .vendredi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
            '${Provider.of<PlanningClass>(context, listen: false).post!.vendredi![1][index]["type_poubelle"]}',
            startTime,
            endTime,
            Provider.of<PlanningClass>(context, listen: false)
                        .post!
                        .vendredi![1][index]["type_poubelle"] ==
                    "plastique"
                ? Colors.blue
                : Provider.of<PlanningClass>(context, listen: false)
                            .post!
                            .vendredi![1][index]["type_poubelle"] ==
                        "papier"
                    ? Colors.amber
                    : Provider.of<PlanningClass>(context, listen: false)
                                .post!
                                .vendredi![1][index]["type_poubelle"] ==
                            "canette"
                        ? Colors.red
                        : Colors.green,
            false,
          ));
        });
      }
      if (Provider.of<PlanningClass>(context, listen: false)
          .post!
          .samedi![1]
          .isNotEmpty) {
        List.generate(
            Provider.of<PlanningClass>(context, listen: false)
                .post!
                .samedi![1]
                .length, (index) {
          final DateTime startTime = DateTime(
              today.year,
              today.month,
              today.day + 0,
              int.parse(Provider.of<PlanningClass>(context, listen: false)
                  .post!
                  .samedi![1][index]["start"]),
              0,
              0);
          final DateTime endTime = startTime.add(const Duration(hours: 3));
          meetings.add(Meeting(
              '${Provider.of<PlanningClass>(context, listen: false).post!.samedi![1][index]["type_poubelle"]}',
              startTime,
              endTime,
              Provider.of<PlanningClass>(context, listen: false)
                          .post!
                          .samedi![1][index]["type_poubelle"] ==
                      "plastique"
                  ? Colors.blue
                  : Provider.of<PlanningClass>(context, listen: false)
                              .post!
                              .samedi![1][index]["type_poubelle"] ==
                          "papier"
                      ? Colors.amber
                      : Provider.of<PlanningClass>(context, listen: false)
                                  .post!
                                  .samedi![1][index]["type_poubelle"] ==
                              "canette"
                          ? Colors.red
                          : Colors.green,
              false));
        });
      }
    }

    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<PlanningClass>(context, listen: true);
    return postModel.loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(backgroundColor: Colors.green),
            body: SfCalendar(
              view: CalendarView.month,
              dataSource: MeetingDataSource(_getDataSource()),
              firstDayOfWeek: 1,
              monthCellBuilder: monthCellBuilder,
              monthViewSettings: MonthViewSettings(
                showAgenda: true,
                appointmentDisplayCount: 4,
                appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                agendaViewHeight: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
          );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
