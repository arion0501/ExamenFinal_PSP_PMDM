import 'package:cloud_firestore/cloud_firestore.dart';

class ProductosFS {
  final String nombre;
  final String descripcion;
  final double precio;
  final DateTime fecha;

  ProductosFS(
      {required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.fecha});

  factory ProductosFS.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductosFS(
      nombre: data?['nombre'],
      descripcion: data?['descripcion'],
      precio: data?['precio'] != null ? data!['precio'] : 0,
      fecha: (data?['fecha'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre,
      "descripcion": descripcion,
      "precio": precio,
      "fecha": fecha
    };
  }
}