import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final String nombre;
  final double dFontSize;
  final MaterialColor mcColores;
  final int iPosicion;
  final Function(int indice)? onItemListClickedFun;
  final String imagen;
  final double precio;

  const CustomListView({
    Key? key,
    required this.nombre,
    required this.dFontSize,
    required this.mcColores,
    required this.iPosicion,
    required this.onItemListClickedFun,
    required this.imagen,
    required this.precio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: mcColores,
        child: Row(
          children: [
            Padding(padding: EdgeInsets.all(8.0)),
            Image.network(
              imagen,
              width: 100,
              height: 100,
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nombre, style: TextStyle(fontSize: dFontSize)),
                Text('${precio.toStringAsFixed(2)}\€', style: TextStyle(fontSize: dFontSize)),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        onItemListClickedFun!(iPosicion);
      },
    );
  }
}
