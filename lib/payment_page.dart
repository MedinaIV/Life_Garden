import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/produto.dart' as model;
import 'home_page.dart';

class PaymentPage extends StatefulWidget {
  final List<model.Produto> produtos;

  const PaymentPage({Key? key, required this.produtos}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _numeroController = TextEditingController();
  final _vencimentoController = TextEditingController();
  final _cvvController = TextEditingController();

  String _formaPagamento = 'Cartão de Crédito';

  @override
  Widget build(BuildContext context) {
    double total = widget.produtos.fold(
      0,
      (soma, p) => soma + double.parse(p.preco.replaceAll(",", ".")),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamento"),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Forma de Pagamento",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _formaPagamento,
                items: [
                  'Cartão de Crédito',
                  'Pix',
                ].map((opcao) {
                  return DropdownMenuItem<String>(
                    value: opcao,
                    child: Text(opcao),
                  );
                }).toList(),
                onChanged: (valor) {
                  setState(() {
                    _formaPagamento = valor!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Escolha a forma de pagamento",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              if (_formaPagamento == 'Cartão de Crédito') ...[
                const Text(
                  "Dados do Cartão",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: "Nome no Cartão",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _numeroController,
                  decoration: const InputDecoration(
                    labelText: "Número do Cartão",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _vencimentoController,
                  decoration: const InputDecoration(
                    labelText: "Data de Vencimento",
                    hintText: "MM/AA",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _cvvController,
                  decoration: const InputDecoration(
                    labelText: "Código de Segurança (CVV)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
              ],

              const Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "R\$ ${total.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (_formaPagamento == 'Cartão de Crédito')
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _mostrarConfirmacao(context);
                    }
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("Finalizar Compra"),
                  style: _estiloBotao(),
                ),

              if (_formaPagamento == 'Pix')
                ElevatedButton.icon(
                  onPressed: () {
                    _mostrarConfirmacao(context, tipo: "QR Code Pix gerado!");
                  },
                  icon: const Icon(Icons.qr_code),
                  label: const Text("Gerar QR Code Pix"),
                  style: _estiloBotao(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarConfirmacao(BuildContext context, {String tipo = "Compra realizada com sucesso."}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pagamento"),
        content: Text(tipo),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
                (route) => false,
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  ButtonStyle _estiloBotao() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}