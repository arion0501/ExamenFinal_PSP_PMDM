import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FirestoreObjects/ProductosFS.dart';
import '../FirestoreObjects/UsuarioFS.dart';
import 'Admin.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder {
  static final DataHolder _dataHolder = DataHolder._internal();
  FirebaseFirestore fs = FirebaseFirestore.instance;
  GeolocAdmin geolocAdmin = GeolocAdmin();
  Admin admin = Admin();
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  UsuariosFS? usuario;

  late ProductosFS selectedProduct;
  ProductosFS? productoGuardado;
  String sNombre = "Examen Final DataHolder";
  late PlatformAdmin platformAdmin;

  DataHolder._internal() {
    platformAdmin = PlatformAdmin();
  }

  void crearProductoEnFB(ProductosFS producto) {
    CollectionReference<ProductosFS> productoRef = fs
        .collection("Productos")
        .withConverter(
            fromFirestore: ProductosFS.fromFirestore,
            toFirestore: (ProductosFS producto, _) => producto.toFirestore());

    productoRef.add(producto);
  }

  void saveSelectedProductInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nombre', selectedProduct.nombre);
    prefs.setString('descripcion', selectedProduct.descripcion);
    prefs.setDouble('precio', selectedProduct.precio);
    prefs.setString('fecha', selectedProduct.fecha as String);
  }

  void initDataHolder() {}

  Future<ProductosFS?> initCachedFbProducto() async {
    if (productoGuardado != null) return productoGuardado;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? nombre = prefs.getString('nombre');
    nombre ??= "";

    String? descripcion = prefs.getString('descripcion');
    descripcion ??= "";

    double? precio = prefs.getDouble('precio');
    precio ??= 0;

    DateTime? fecha = DateTime.parse(prefs.getString('fecha') ?? "");

    productoGuardado = ProductosFS(
        nombre: nombre, descripcion: descripcion, precio: precio, fecha: fecha);

    return productoGuardado;
  }

  factory DataHolder() {
    return _dataHolder;
  }

  void suscribeACambiosGPSUsuario() {
    geolocAdmin.registrarCambiosLoc(posicionDelMovilCambio);
  }

  void posicionDelMovilCambio(Position? position) {
    usuario!.geoloc = GeoPoint(position!.latitude, position.longitude);
    fbAdmin.actualizarPerfilUsuario(usuario!);
  }
}