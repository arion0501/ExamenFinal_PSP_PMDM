import 'package:examen_final_psp_pmdm/OnBoarding/loginView.dart';
import 'package:flutter/material.dart';
import 'OnBoarding/registerView.dart';

class ActividadExamen extends StatelessWidget {
  const ActividadExamen({super.key});
  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = const MaterialApp();
    {
      materialApp = MaterialApp(
        title: "Examen PMDM Marcos Garcia",
        debugShowCheckedModeBanner: false,
        routes: {
          '/vistalogin': (context) => const loginView(),
          '/vistaregister': (context) => const registerView(),
        },
        initialRoute: '/vistalogin',
      );
      return materialApp;
    }
  }
}