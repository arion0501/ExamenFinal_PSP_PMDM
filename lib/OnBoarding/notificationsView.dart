import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class notificationsView extends StatefulWidget {
  const notificationsView({Key? key});

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<notificationsView> {
  late BuildContext _context;
  FirebaseFirestore fs = FirebaseFirestore.instance;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: Colors.blueGrey[700],
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: const Text(
                    'No hay notificaciones recientes',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 30),
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.popAndPushNamed(context, '/vistahome');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple[700],
                      ),
                      child: const Text('Volver a Inicio'),
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
