import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosFS {
  final String nombre;
  final String apellidos;
  final int edad;
  GeoPoint geoloc;

  UsuariosFS(
      {required this.nombre,
      required this.apellidos,
      required this.edad,
      required this.geoloc});

  factory UsuariosFS.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UsuariosFS(
        nombre: data?['nombre'],
        apellidos: data?['apellidos'],
        edad: data?['edad'] != null ? data!['edad'] : 0,
        geoloc:
            data?['geoloc'] != null ? data!['geoloc'] : const GeoPoint(0, 0));
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre,
      "apellidos": apellidos,
      "edad": edad,
      "geoloc": geoloc,
    };
  }
}
