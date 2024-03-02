import 'package:flutter/material.dart';

class loginView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
        backgroundColor: Colors.blueGrey[700],
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(60),
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(20),
          ),

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
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
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
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Proporciona tu contraseña';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
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
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple[700],
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
