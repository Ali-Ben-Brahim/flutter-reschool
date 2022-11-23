import 'package:estionnaire/gestionnaire/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../gestionnaire/pages/login.dart';
import '../pages/profile.dart';
import '../pages/resetPassword.dart';





class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF196f3d),
          title:const Center(
            child:  Text("Profile",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                )),
          )),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const Profile()),
              ));
            },
            icon:const Icon(
              Icons.account_circle_rounded,
              size: 24.0,
            ),
            label: const Text('Mes information'), 
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const ResetPassword()),
              ));
            },
            icon: const Icon(
              Icons.lock_reset,
              size: 24.0,
            ),
            label: const Text('Changer mot de passe'), 
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              
            },
            icon:const Icon(
              Icons.info,
              size: 24.0,
            ),
            label: const Text('A propos'),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              Provider.of<LoginProvider>(context,listen: false).logout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>const Login()), (route) => false);
            },
            icon:const Icon(
              Icons.logout,
              size: 24.0,
            ),
            label: const Text('Déconnecter'), 
          ),
        ],
      )),
    );
  }
}
