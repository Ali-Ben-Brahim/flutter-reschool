




import 'package:flutter/cupertino.dart';

import '../services/dashboard_services.dart';

class DashboardProvider extends ChangeNotifier{
final DashboardServices _dashboardServices = DashboardServices();


getStatistiquesGenerales(){
  _dashboardServices.getStatistiquesGenerales();
}
  
}