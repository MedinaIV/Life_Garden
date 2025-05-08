import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar Senha"),
        backgroundColor: LifeGardenColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text("Digite seu e-mail e enviaremos um link para redefinir sua senha."),
            const SizedBox(height: 16),
            TextField(decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Email enviado"),
                      content: const Text("Verifique seu e-mail para redefinir sua senha."),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: LifeGardenColors.primary),
                child: const Text("Enviar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

