import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginPhone extends StatefulWidget {
  const loginPhone({super.key});

  @override
  _LoginPhoneViewState createState() => _LoginPhoneViewState();
}

class _LoginPhoneViewState extends State<loginPhone> {
  late GlobalKey<FormState> _formKey;
  late BuildContext _context;

  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();
  String sVerificationCode = "";
  bool blMostrarVerification = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  void enviarTelefonoPressed() async {
    String sTelefono = tecPhone.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: sTelefono,
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codigoEnviado,
      codeAutoRetrievalTimeout: tiempoDeEsperaAcabado,
    );
  }

  void enviarVerifyPressed() async{
    String smsCode = tecVerify.text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);
    print('hola1');

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    print('hola');
    Navigator.of(context).popAndPushNamed('/vistahome');
  }

  void verificacionCompletada(PhoneAuthCredential credencial) async{
    await FirebaseAuth.instance.signInWithCredential(credencial);

    Navigator.of(context).popAndPushNamed('/vistahome');
  }

  void verificacionFallida(FirebaseAuthException excepcion) {
    if (excepcion.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void codigoEnviado(String codigo, int? resendToken) async{
    sVerificationCode = codigo;
    setState(() {
      blMostrarVerification = true;
    });
  }

  void tiempoDeEsperaAcabado(String tiempoCodigo) {

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
                      return 'Proporciona tu número de teléfono';
                    }
                    return null;
                  },
                  controller: tecPhone,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Número de teléfono',
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
                if(blMostrarVerification)
                  TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Proporciona tu código de verificación';
                    }
                    return null;
                  },
                  controller: tecVerify,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Código de Verificación',
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
                          enviarTelefonoPressed();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple[700],
                      ),
                      child: const Text('Enviar'),
                    ),
                    if (blMostrarVerification)
                      ElevatedButton(
                        onPressed: () {
                          enviarVerifyPressed();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purple[700],
                        ),
                        child: const Text('Enviar (código)'),
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