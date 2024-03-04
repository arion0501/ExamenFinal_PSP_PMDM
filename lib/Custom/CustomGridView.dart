import 'package:examen_final_psp_pmdm/FirestoreObjects/ProductosFS.dart';
import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final List<ProductosFS> productos;
  final int iPosicion;
  final Function(int indice)? onItemListClickedFun;

  const CustomGridView(
      {super.key, required this.productos,
        required this.iPosicion,
        required this.onItemListClickedFun,});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              color: Colors.blueGrey,
              child: Center(
                child: Text(
                  productos[index].nombre,
                  style: const TextStyle(fontSize: 20, color: Colors.white70),
                ),
              ),
            ),
            onTap: () {
              onItemListClickedFun!(index);
            },
          );
        });
  }
}