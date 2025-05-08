import 'package:flutter/material.dart';
import 'package:flutter_application_1/payment_page.dart';
import 'package:flutter_application_1/model/produto.dart';

class FinalizePurchasePage extends StatelessWidget {
  final List<Produto> produtos;

  const FinalizePurchasePage({super.key, required this.produtos});

  @override
  Widget build(BuildContext context) {
    double total = produtos.fold(0, (soma, p) => soma + double.parse(p.preco));

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Finalização de Compra"),
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.manage_accounts)),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.green[600],
            padding: const EdgeInsets.all(14),
            child: const Text(
              "🎉 Você economizou R\$ 50 hoje!",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(produto.imagem, width: 70, height: 70, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(produto.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(produto.detalhes, style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 8),
                              Text("R\$ ${produto.preco}",
                                  style: const TextStyle(fontSize: 16, color: Colors.green)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Checkbox(value: true, onChanged: (v) {}),
                const Text("Selecionar tudo"),
                const Spacer(),
                const Text("Total: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("R\$ ${total.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(produtos: produtos),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Ir para Pagamento"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
