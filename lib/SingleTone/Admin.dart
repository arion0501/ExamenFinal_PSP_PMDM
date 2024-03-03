import 'dart:convert';
import 'package:http/http.dart' as http;

class Admin {
  Admin();

  Future<Map<String, dynamic>> obtenerUbicacionCliente() async {
    const apiKey = '13114d2ba29e2b';
    const apiUrl = 'https://ipinfo.io/json?token=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Error al obtener información de ubicación.');
    }
  }
}