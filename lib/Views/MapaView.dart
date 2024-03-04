import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaView extends StatefulWidget {
  @override
  State<MapaView> createState() => MapaViewState();
}

class MapaViewState extends State<MapaView> {
  late GoogleMapController _controller;
  Set<Marker> tiendas = Set();

  static final CameraPosition madridCentro = CameraPosition(
    target: LatLng(40.4168, -3.7038),
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white70,
        title: const Text('Mapa de Ubicaciones'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: madridCentro,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: tiendas,
            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
              ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                onPressed: _dirigirseTiendas,
                label: Text('Visualizar tiendas cercanas'),
                icon: Icon(Icons.my_location),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dirigirseTiendas() async {
    CameraPosition cercanas = CameraPosition(
      target: LatLng(40.4227274, -3.5312032),
      tilt: 59.440717697143555,
      zoom: 16,
    );

    _controller.animateCamera(CameraUpdate.newCameraPosition(cercanas));

    Marker tienda1 = Marker(
      markerId: MarkerId('1'),
      position: LatLng(40.432999470281096, -3.5334851040598427),
      infoWindow: InfoWindow(
        title: 'Leroy Merlín Gran Vía',
        snippet: 'Calle Falsa 2',
      ),
    );

    Marker tienda2 = Marker(
      markerId: MarkerId('2'),
      position: LatLng(40.4272174011443, -3.5267903107408456),
      infoWindow: InfoWindow(
        title: 'Leroy Merlín Rivas-Vaciamadrid',
        snippet: 'Calle Los Almendros 2',
      ),
    );

    Marker tienda3 = Marker(
      markerId: MarkerId('3'),
      position: LatLng(40.42427717533754, -3.5325409665404974),
      infoWindow: InfoWindow(
        title: 'Leroy Merlín Arganda del Rey',
        snippet: 'Avenida de la Alegría 32',
      ),
    );

    Marker tienda4 = Marker(
      markerId: MarkerId('4'),
      position: LatLng(40.42213726352629, -3.5344614280855304),
      infoWindow: InfoWindow(
        title: 'Leroy Merlín Vicálvaro',
        snippet: 'Avenida de Irún 7',
      ),
    );

    setState(() {
      tiendas.add(tienda1);
      tiendas.add(tienda2);
      tiendas.add(tienda3);
      tiendas.add(tienda4);
    });
  }
}
