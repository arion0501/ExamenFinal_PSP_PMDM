import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../FirestoreObjects/UsuarioFS.dart';

class perfilView extends StatefulWidget {
  const perfilView({Key? key}) : super(key: key);

  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<perfilView> {
  late BuildContext _context;
  late GlobalKey<FormState> _formKey;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecApellidos = TextEditingController();
  TextEditingController tecEdad = TextEditingController();

  FirebaseFirestore fb = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    cargarDatosUsuario();
  }

  void cargarDatosUsuario() async {
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> doc =
    await fb.collection("Perfiles").doc(uidUsuario).get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data()!;
      setState(() {
        tecNombre.text = data['nombre'];
        tecApellidos.text = data['apellidos'];
        tecEdad.text = data['edad'].toString();
      });
    }
  }

  void onClickAceptar() async {
    UsuariosFS usuario = UsuariosFS(
      nombre: tecNombre.text,
      apellidos: tecApellidos.text,
      edad: int.parse(tecEdad.text),
      geoloc: const GeoPoint(0, 0),
    );
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
    await fb.collection("Perfiles").doc(uidUsuario).set(usuario.toFirestore());

    Navigator.of(_context).popAndPushNamed('/vistahome');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Crear Perfil'),
        backgroundColor: Colors.blueGrey[700],
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Introduce tu nombre';
                    }
                    return null;
                  },
                  controller: tecNombre,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Introduce tu apellido';
                    }
                    return null;
                  },
                  controller: tecApellidos,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Apellido',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Introduce tu edad';
                    }
                    return null;
                  },
                  controller: tecEdad,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onClickAceptar();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple[700],
                      ),
                      child: const Text('Aceptar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(_context).popAndPushNamed('/vistalogin');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple[700],
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}