import 'package:flutter/material.dart';
import '../FirestoreObjects/ProductosFS.dart';

class CustomGridView extends StatelessWidget {
  final List<ProductosFS> productos;
  final int iPosicion;
  final void Function(int index) onItemListClickedFun;

  CustomGridView({
    required this.productos,
    required this.iPosicion,
    required this.onItemListClickedFun,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      padding: const EdgeInsets.all(8),
      itemCount: productos.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            color: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15.0),
                  ),
                  child: Image.network(
                    productos[index].imagen,
                    fit: BoxFit.cover,
                    height: 110.08,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    productos[index].nombre,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Precio: ${productos[index].precio}\€',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            onItemListClickedFun!(index);
          },
        );
      },
    );
  }
}