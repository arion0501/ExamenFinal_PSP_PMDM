import 'package:examen_final_psp_pmdm/Main/vistaCreaProducto.dart';
import 'package:examen_final_psp_pmdm/OnBoarding/homeView.dart';
import 'package:examen_final_psp_pmdm/OnBoarding/loginView.dart';
import 'package:examen_final_psp_pmdm/OnBoarding/perfilView.dart';
import 'package:examen_final_psp_pmdm/Views/MapaView.dart';
import 'package:flutter/material.dart';
import 'OnBoarding/loginPhone.dart';
import 'OnBoarding/notificationsView.dart';
import 'OnBoarding/registerView.dart';
import 'SingleTone/DataHolder.dart';

class ActividadExamen extends StatelessWidget {
  const ActividadExamen({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = const MaterialApp();

    if (DataHolder().platformAdmin.isAndroidPlatform() ||
        DataHolder().platformAdmin.isIOSPlatform()) {
      materialApp = MaterialApp(
        title: "Examen PMDM Marcos Garcia",
        debugShowCheckedModeBanner: false,
        routes: {
          '/vistalogin': (context) => const loginPhone(),
          '/vistaregister': (context) => const registerView(),
          '/vistahome': (context) => const homeView(),
          '/vistaperfil': (context) => const perfilView(),
          '/vistacreaproducto': (context) => const vistaCreaProducto(),
          '/vistamapa': (context) => MapaView(),
          '/vistanotificaciones': (context) => notificationsView(),
        },
        initialRoute: '/vistalogin',
      );
    } else if (DataHolder().platformAdmin.isWebPlatform()) {
      materialApp = MaterialApp(
        title: "Examen PMDM Marcos Garcia",
        debugShowCheckedModeBanner: false,
        routes: {
          '/vistalogin': (context) => const loginView(),
          '/vistaregister': (context) => const registerView(),
          '/vistahome': (context) => const homeView(),
          '/vistaperfil': (context) => const perfilView(),
          '/vistacreaproducto': (context) => const vistaCreaProducto(),
          '/vistamapa': (context) => MapaView(),
          '/vistanotificaciones': (context) => notificationsView(),
        },
        initialRoute: '/vistalogin',
      );
    }
    return materialApp;
  }
}