import 'package:flutter/material.dart';
import 'constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool acceptedTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmSenhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _nascimentoController = TextEditingController();
  final _profissaoController = TextEditingController();
  final _interessesController = TextEditingController();

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Cadastro realizado"),
            content: const Text("Sua conta foi criada com sucesso!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: LifeGardenColors.primary,
      ),
      backgroundColor: LifeGardenColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: _buildInputDecoration(
                  "Nome completo",
                  Icons.person,
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Digite seu nome"
                            : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                decoration: _buildInputDecoration("Email", Icons.email),
                validator:
                    (value) =>
                        value != null && value.contains("@")
                            ? null
                            : "Digite um e-mail válido",
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _senhaController,
                obscureText: _obscurePassword,
                decoration: _buildInputDecoration("Senha", Icons.lock).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed:
                        () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                  ),
                ),
                validator:
                    (value) =>
                        value != null && value.length >= 6
                            ? null
                            : "A senha deve ter no mínimo 6 caracteres",
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _confirmSenhaController,
                obscureText: _obscureConfirm,
                decoration: _buildInputDecoration(
                  "Confirmar senha",
                  Icons.lock_outline,
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed:
                        () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                validator:
                    (value) =>
                        value == _senhaController.text
                            ? null
                            : "As senhas não coincidem",
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _telefoneController,
                decoration: _buildInputDecoration("Telefone", Icons.phone),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Digite o telefone"
                            : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _enderecoController,
                decoration: _buildInputDecoration("Endereço", Icons.home),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Digite o endereço"
                            : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _nascimentoController,
                decoration: _buildInputDecoration(
                  "Data de nascimento",
                  Icons.calendar_today,
                ),
                keyboardType: TextInputType.datetime,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? "Digite a data" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _profissaoController,
                decoration: _buildInputDecoration("Profissão", Icons.work),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Checkbox(
                    value: acceptedTerms,
                    onChanged:
                        (value) =>
                            setState(() => acceptedTerms = value ?? false),
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'Eu aceito os ',
                        children: [
                          TextSpan(
                            text: 'Termos de Uso',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: ' e a '),
                          TextSpan(
                            text: 'Política de Privacidade',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && acceptedTerms) {
                      _showConfirmationDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LifeGardenColors.primary,
                  ),
                  child: const Text("Cadastrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
