import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/pelicula_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final service = PeliculaService();
  final titulo = TextEditingController();
  final anio = TextEditingController();
  final director = TextEditingController();
  final genero = TextEditingController();
  final sinopsis = TextEditingController();
  File? imagen;

  Future<void> seleccionarImagen() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => imagen = File(img.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Película")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titulo,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: anio,
              decoration: const InputDecoration(labelText: "Año"),
            ),
            TextField(
              controller: director,
              decoration: const InputDecoration(labelText: "Director"),
            ),
            TextField(
              controller: genero,
              decoration: const InputDecoration(labelText: "Género"),
            ),
            TextField(
              controller: sinopsis,
              decoration: const InputDecoration(labelText: "Sinopsis"),
            ),
            const SizedBox(height: 10),
            imagen != null
                ? Image.file(imagen!, height: 120)
                : const Text("Sin imagen"),
            TextButton.icon(
              onPressed: seleccionarImagen,
              icon: const Icon(Icons.image),
              label: const Text("Seleccionar Imagen"),
            ),
            ElevatedButton(
              onPressed: () async {
                await service.agregarPelicula({
                  'titulo': titulo.text,
                  'anio': anio.text,
                  'director': director.text,
                  'genero': genero.text,
                  'sinopsis': sinopsis.text,
                }, imagen);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Película agregada")),
                );
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
