class PlanningModel {
  List? lundi;
  List? mardi;
  List? mercredi;
  List? jeudi;
  List? vendredi;
  List? samedi;
  String? day;

  PlanningModel({ this.lundi, this.mardi,this.mercredi,this.jeudi,this.vendredi,this.samedi   ,this.day});

  factory PlanningModel.fromJson(List json) {
    return PlanningModel(
      lundi: json[0],
      mardi: json[1],
      mercredi: json[2],
      jeudi: json[3],
      vendredi: json[4],
      samedi: json[5],
     
      day: json[0][0],
    );
  }
}
