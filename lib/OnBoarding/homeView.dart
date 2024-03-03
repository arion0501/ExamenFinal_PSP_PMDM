import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../SingleTone/DataHolder.dart';

class homeView extends StatefulWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<homeView> {
  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  void apiUbicacion() async {
    try {
      Map<String, dynamic> ubicacionCliente =
          await DataHolder().admin.obtenerUbicacionCliente();

      String ip = ubicacionCliente['ip'];
      String ciudad = ubicacionCliente['city'];
      String region = ubicacionCliente['region'];
      String pais = ubicacionCliente['country'];
      String codigoPostal = ubicacionCliente['postal'];
      double latitud =
          double.parse(ubicacionCliente['loc']?.split(',')[0] ?? '0');
      double longitud =
          double.parse(ubicacionCliente['loc']?.split(',')[1] ?? '0');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Información de Ubicación del Cliente'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('IP: $ip'),
                Text('Ciudad: $ciudad'),
                Text('Región: $region'),
                Text('País: $pais'),
                Text('Código Postal: $codigoPostal'),
                Text('Latitud: $latitud'),
                Text('Longitud: $longitud'),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Error al obtener la ubicación del cliente'),
            actions: [
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void buscarBy() {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Buscar item por ?'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Ingrese item a buscar',
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  String searchValue = searchController.text.trim();
                  if (searchValue.isNotEmpty) {
                    Navigator.of(context)
                        .pop(); // Cerrar el diálogo de búsqueda
                    buscarAsync(searchValue);
                  }
                },
                child: const Text('Buscar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void buscarAsync(String searchValue) async {
    List<String> matches = [];

    /*for (var post in ?) {
      if (post.titulo.toLowerCase().startsWith(searchValue.toLowerCase())) {
        matches.add(post.titulo);
      }
    }*/

    if (matches.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Resultados de la Búsqueda'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Se encontraron items: $searchValue'),
                for (var match in matches) Text('• $match'),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Resultados de la Búsqueda'),
            content: Text('No se encontraron items: $searchValue'),
            actions: [
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Productos'),
        backgroundColor: Colors.blueGrey[700],
        foregroundColor: Colors.white70,
        actions: [
          PopupMenuButton(
            onSelected: (indice) {
              switch (indice) {
                case 'busca':
                  buscarBy();
                  break;
                case 'apiUbicacion':
                  apiUbicacion();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'apiUbicacion',
                child: ListTile(
                  leading: Icon(Icons.map_rounded),
                  title: Text('Ubicación'),
                ),
              ),
              const PopupMenuItem(
                value: 'busca',
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Buscar por ?'),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/vistacreaproducto");
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
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blueGrey[900],
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                accountName: Text('Leroy Merlin'),
                accountEmail: null,
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('resources/leroyMerlin.jpeg'),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/vistahome');
              },
            ),
            ListTile(
              leading: const Icon(Icons.map, color: Colors.white),
              title: const Text('Mapa de ubicaciones',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/vistamapa');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Cerrar sesión',
                  style: TextStyle(color: Colors.white)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, '/vistalogin');
              },
            ),
          ],
        ),
      ),
    );
  }
}