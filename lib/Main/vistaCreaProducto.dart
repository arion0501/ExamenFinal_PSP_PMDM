import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class vistaCreaProducto extends StatefulWidget {
  const vistaCreaProducto({Key? key}) : super(key: key);

  @override
  _VistaCreaProductoState createState() => _VistaCreaProductoState();
}

class _VistaCreaProductoState extends State<vistaCreaProducto> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _imagePreview;
  late BuildContext _context;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecDescripcion = TextEditingController();
  TextEditingController tecPrecio = TextEditingController();

  DateTime fecha = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
        title: const Text(
          "Registrar Producto",
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(color: Colors.white70),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _onPressedGallery,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: _imagePreview != null
                                    ? FileImage(_imagePreview!)
                                    : null,
                                child: _imagePreview == null
                                    ? const Icon(Icons.image,
                                        size: 70, color: Colors.white70)
                                    : null,
                              ),
                              Positioned(
                                bottom: 6,
                                right: 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 26,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TextFormField(
                            controller: tecNombre,
                            decoration: const InputDecoration(
                                labelText: 'Nombre del producto'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el nombre del producto';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TextFormField(
                            controller: tecDescripcion,
                            decoration: const InputDecoration(
                                labelText: 'Descripción del producto'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa la descripción del producto';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TextFormField(
                            controller: tecPrecio,
                            decoration: const InputDecoration(
                                labelText: 'Precio del producto'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el precio del producto';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: InkWell(
                            onTap: _seleccionarFecha,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Fecha',
                                icon: Icon(Icons.calendar_today_rounded),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${fecha.day}/${fecha.month}/${fecha.year}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _guardarProducto();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.purple[700],
                              ),
                              child: const Text(
                                'Guardar',
                                style: TextStyle(
                                    fontSize: 14),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .popAndPushNamed('/vistahome');
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.purple[700],
                              ),
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (fechaSeleccionada != null) {
      setState(() {
        fecha = fechaSeleccionada;
      });
    }
  }

  void _guardarProducto() {
    String nombre = tecNombre.text.trim();
    String descripcion = tecDescripcion.text.trim();
    double precio = double.tryParse(tecPrecio.text.trim()) ?? 0.0;
  }

  void _onPressedGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }
}