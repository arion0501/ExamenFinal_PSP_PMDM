import 'package:examen_final_psp_pmdm/FirestoreObjects/ProductosFS.dart';
import 'package:flutter/material.dart';
import '../SingleTone/DataHolder.dart';

class vistaProducto extends StatefulWidget {
  const vistaProducto({super.key});

  @override
  State<vistaProducto> createState() => _PostViewState();
}

class _PostViewState extends State<vistaProducto> {
  ProductosFS ProductoInfo = ProductosFS(
      nombre: "nombre",
      descripcion: "descripcion",
      precio: 13,
      fecha: DateTime(1),
      imagen: "");

  @override
  void initState() {
    super.initState();
    cargarProductoGuardadoEnCache();
  }

  void cargarProductoGuardadoEnCache() async {
    var temp1 = await DataHolder().initCachedFbProducto();

    setState(() {
      ProductoInfo = temp1!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          DataHolder().sNombre,
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: Image.network(ProductoInfo.imagen, width: 750, height: 750),
          ),
          const SizedBox(height: 16),
          Text(ProductoInfo.nombre,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white70)),
          const SizedBox(height: 16),
          Text(ProductoInfo.descripcion, style: TextStyle(color: Colors.white70, fontSize: 20)),
          const SizedBox(height: 16),
          Text('Precio: ${ProductoInfo.precio.toString()}\€', style: TextStyle(color: Colors.white70, fontSize: 20)),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/vistahome');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.purple[700],
            ),
            child: const Text('Volver'),
          ),
        ],
      ),
    );
  }
}