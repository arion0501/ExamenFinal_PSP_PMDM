import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../FirestoreObjects/UsuarioFS.dart';

class FirebaseAdmin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void actualizarPerfilUsuario(UsuariosFS usuario) async {
    // UID del usuario que está logeado
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    // Crear documento con un ID nuestro
    await db.collection("Perfiles").doc(uidUser).set(usuario.toFirestore());
  }
}