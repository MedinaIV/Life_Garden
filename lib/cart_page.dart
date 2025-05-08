import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/produto.dart';
import 'payment_page.dart';

class PaginaCarrinho extends StatelessWidget {
  final List<Produto> produtos;

  const PaginaCarrinho({super.key, required this.produtos});

  @override
  Widget build(BuildContext context) {
    double total = produtos.fold(0, (soma, p) {
      double preco = double.parse(p.preco.replaceAll(",", "."));
      return soma + preco;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho de Compras"),
        backgroundColor: Colors.green[800],
      ),
      body: produtos.isEmpty
          ? const Center(child: Text("Seu carrinho está vazio!"))
          : ListView.builder(
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
                              Text("R\$ ${produto.preco}", style: const TextStyle(fontSize: 16, color: Colors.green)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                Text("Total: R\$ ${total.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
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
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Finalizar Compra",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
