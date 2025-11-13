import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetalleScreen extends StatelessWidget {
  const DetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doc = ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;

    return Scaffold(
      appBar: AppBar(title: Text(doc['titulo'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(doc['imagenUrl'] ?? ''),
            const SizedBox(height: 10),
            Text(
              "${doc['titulo']} (${doc['anio']})",
              style: const TextStyle(fontSize: 20),
            ),
            Text("Director: ${doc['director']}"),
            Text("Género: ${doc['genero']}"),
            const SizedBox(height: 10),
            Text(doc['sinopsis']),
          ],
        ),
      ),
    );
  }
}
