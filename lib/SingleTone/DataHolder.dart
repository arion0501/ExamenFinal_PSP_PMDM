import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../FirestoreObjects/UsuarioFS.dart';
import 'Admin.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();
  FirebaseFirestore fs = FirebaseFirestore.instance;
  GeolocAdmin geolocAdmin = GeolocAdmin();
  Admin admin = Admin();
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  UsuariosFS? usuario;

  String sNombre = "Examen Final DataHolder";
  late String sPostTitulo;
  late PlatformAdmin platformAdmin;

  DataHolder._internal() {
    platformAdmin = PlatformAdmin();
  }

  void initDataHolder() {

  }

  factory DataHolder(){
    return _dataHolder;
  }

  void suscribeACambiosGPSUsuario () {
    geolocAdmin.registrarCambiosLoc(posicionDelMovilCambio);
  }

  void posicionDelMovilCambio(Position? position) {
    usuario!.geoloc = GeoPoint(position!.latitude, position.longitude);
    fbAdmin.actualizarPerfilUsuario(usuario!);
  }
}