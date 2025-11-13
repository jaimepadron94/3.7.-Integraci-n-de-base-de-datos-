import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Login / Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await auth.login(email.text, password.text);
                if (auth.user != null) {
                  Navigator.pushReplacementNamed(context, '/catalogo');
                }
              },
              child: const Text("Ingresar"),
            ),
            TextButton(
              onPressed: () async {
                await auth.register(email.text, password.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Usuario registrado")),
                );
              },
              child: const Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}
