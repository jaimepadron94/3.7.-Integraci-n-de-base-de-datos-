import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/pelicula_service.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = PeliculaService();
    return Scaffold(
      appBar: AppBar(title: const Text("Catálogo de Películas")),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.obtenerPeliculas(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: docs.length,
            itemBuilder: (ctx, i) {
              final d = docs[i];
              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, '/detalle', arguments: d),
                child: Card(
                  child: Column(
                    children: [
                      Image.network(
                        d['imagenUrl'] ?? '',
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Text(d['titulo'] ?? 'Sin título'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/admin'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
