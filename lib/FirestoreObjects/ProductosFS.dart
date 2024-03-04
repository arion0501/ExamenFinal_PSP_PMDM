import 'package:cloud_firestore/cloud_firestore.dart';

class ProductosFS {
  final String nombre;
  final String descripcion;
  final double precio;
  final DateTime fecha;
  final String imagen;

  ProductosFS(
      {required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.fecha,
      required this.imagen
      });

  factory ProductosFS.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductosFS(
      nombre: data?['nombre'],
      descripcion: data?['descripcion'],
      precio: data?['precio'] != null ? (data!['precio'] as num).toDouble() : 0.0,
      fecha: (data?['fecha'] as Timestamp).toDate(),
      imagen: data?['imagen'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre,
      "descripcion": descripcion,
      "precio": precio,
      "fecha": fecha,
      "imagen": imagen
    };
  }
}