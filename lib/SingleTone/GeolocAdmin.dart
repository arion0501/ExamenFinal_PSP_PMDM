import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class GeolocAdmin {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<List<String>> obtenerUsuariosEnRango() async {
    List<String> usersInRange = [];

    try {
      // Obtén la posición actual del usuario
      Position userPosition = await Geolocator.getCurrentPosition();

      // Realiza la consulta en Firestore
      double radius = 5.0; // Radio en kilómetros
      GeoPoint center = GeoPoint(userPosition.latitude, userPosition.longitude);

      // Realiza una consulta que obtenga documentos dentro de un cuadrado
      // (puedes ajustar esto según tus necesidades y considerar la esfericidad de la Tierra)
      double latOffset = radius / 110.574;
      double lonOffset = radius / (111.32 * cos(center.latitude * pi / 180));

      QuerySnapshot result = await FirebaseFirestore.instance
          .collection('Usuarios')
          .where('localizacion',
          isGreaterThan: GeoPoint(
              center.latitude - latOffset, center.longitude - lonOffset))
          .where('localizacion',
          isLessThan: GeoPoint(
              center.latitude + latOffset, center.longitude + lonOffset))
          .get();

      // Itera sobre los documentos y agrega los idUser a la lista
      for (var doc in result.docs) {
        usersInRange.add(doc['nombre']);
      }
    } catch (e) {
      print('Error al obtener usuarios en rango: $e');
    }

    return usersInRange;
  }

  void registrarCambiosLoc(Function(Position? position) funCambioPos) {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen(funCambioPos);
  }
}