import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPerfilView extends StatefulWidget {
  const EditPerfilView({Key? key}) : super(key: key);

  @override
  _EditPerfilViewState createState() => _EditPerfilViewState();
}

class _EditPerfilViewState extends State<EditPerfilView> {
  late BuildContext _context;
  FirebaseFirestore fs = FirebaseFirestore.instance;
  late GlobalKey<FormState> _formKey;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecApellidos = TextEditingController();
  TextEditingController tecEdad = TextEditingController();

  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    cargarDatosUsuario();
  }

  void cargarDatosUsuario() async {
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> doc =
    await fs.collection("Perfiles").doc(uidUsuario).get();

    if (doc.exists) {
      setState(() {
        tecNombre.text = doc['nombre'];
        tecApellidos.text = doc['apellidos'];
        tecEdad.text = doc['edad'].toString();
      });
    }
  }

  void activarEdicion() {
    setState(() {
      _editing = true;
    });
  }

  void guardarCambios() async {
    if (_formKey.currentState!.validate()) {
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
      await fs.collection("Perfiles").doc(uidUsuario).update({
        'nombre': tecNombre.text,
        'apellidos': tecApellidos.text,
        'edad': int.parse(tecEdad.text),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cambios guardados con éxito'),
        ),
      );

      Navigator.pop(context);
      Navigator.pushNamed(context, '/vistahome');

      setState(() {
        _editing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.blueGrey[700],
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 310,
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
                      enabled: _editing,
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
                      enabled: _editing,
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
                      enabled: _editing,
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
                          onPressed: _editing ? guardarCambios : activarEdicion,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.purple[700],
                          ),
                          child: Text(_editing ? 'Guardar Cambios' : 'Editar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(_context).popAndPushNamed('/vistahome');
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
            Positioned(
              top: 5,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Edita tu perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}