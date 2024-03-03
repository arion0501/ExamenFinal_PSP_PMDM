import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../FirestoreObjects/UsuarioFS.dart';

class loginView extends StatefulWidget {
  const loginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<loginView> {
  late GlobalKey<FormState> _formKey;
  late BuildContext _context;
  FirebaseFirestore fs = FirebaseFirestore.instance;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  void onClickLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text, password: tecPassword.text);

      String uidUser = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<UsuariosFS> reference = fs
          .collection("Perfiles")
          .doc(uidUser)
          .withConverter(
              fromFirestore: UsuariosFS.fromFirestore,
              toFirestore: (UsuariosFS usuario, _) => usuario.toFirestore());

      DocumentSnapshot<UsuariosFS> docSnap = await reference.get();
      if (docSnap.exists) {
        UsuariosFS usuario = docSnap.data()!;
        print("nombre login user: ${usuario.nombre}");
        Navigator.of(_context).popAndPushNamed('/vistahome');
      } else {
        Navigator.of(_context).popAndPushNamed('/vistaperfil');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

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
                      return 'Proporciona tu email';
                    }
                    return null;
                  },
                  controller: tecUsername,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
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
                      return 'Proporciona tu contraseña';
                    }
                    return null;
                  },
                  controller: tecPassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onClickLogin();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple[700],
                      ),
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(_context)
                            .popAndPushNamed('/vistaregister');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple[700],
                      ),
                      child: const Text('Registro'),
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