import 'package:flutter/material.dart';

class homeView extends StatefulWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<homeView> {
  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        backgroundColor: Colors.blueGrey[700],
        foregroundColor: Colors.white70,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/vistacreapublicacion");
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey[900],
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.grey[400],
        currentIndex: 0,
        onTap: (index) {
          // Aquí puedes agregar la lógica para manejar el cambio de ícono
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'List View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on_rounded),
            label: 'Grid View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
