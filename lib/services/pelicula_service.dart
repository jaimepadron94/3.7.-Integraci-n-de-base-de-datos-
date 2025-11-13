import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PeliculaService {
  final _peliculas = FirebaseFirestore.instance.collection('peliculas');

  Future<String> subirImagen(File file, String nombre) async {
    final ref = FirebaseStorage.instance.ref('peliculas/$nombre.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> agregarPelicula(Map<String, dynamic> data, File? imagen) async {
    if (imagen != null) {
      final url = await subirImagen(
        imagen,
        DateTime.now().millisecondsSinceEpoch.toString(),
      );
      data['imagenUrl'] = url;
    }
    await _peliculas.add(data);
  }

  Stream<QuerySnapshot> obtenerPeliculas() {
    return _peliculas.orderBy('titulo').snapshots();
  }

  Future<void> eliminarPelicula(String id) async {
    await _peliculas.doc(id).delete();
  }
}
