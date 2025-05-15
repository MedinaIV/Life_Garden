import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/model/produto.dart';
import 'package:flutter_application_1/payment_page.dart';
import 'package:flutter_application_1/profile_page.dart';

class PaginaCarrinho extends StatefulWidget {
  final List<Produto> produtos;

  const PaginaCarrinho({super.key, required this.produtos});

  @override
  State<PaginaCarrinho> createState() => _PaginaCarrinhoState();
}

class _PaginaCarrinhoState extends State<PaginaCarrinho> {
  final Map<Produto, TextEditingController> _quantidadeControllers = {};
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    final produtosUnicos = widget.produtos.toSet().toList();
    for (var produto in produtosUnicos) {
      _quantidadeControllers[produto] = TextEditingController(text: "1.0");
    }
  }

  @override
  void dispose() {
    for (var controller in _quantidadeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final produtosUnicos = widget.produtos.toSet().toList();

    double total = 0;
    for (var produto in produtosUnicos) {
      final controller = _quantidadeControllers[produto];
      final quantidade = double.tryParse(controller?.text ?? "0") ?? 0;
      final preco = double.parse(produto.preco.replaceAll(",", "."));
      total += preco * quantidade;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho de Compras"),
        backgroundColor: LifeGardenColors.primary,
      ),
      body: widget.produtos.isEmpty
          ? const Center(child: Text("Seu carrinho está vazio!"))
          : ListView.builder(
              itemCount: produtosUnicos.length,
              itemBuilder: (context, index) {
                final produto = produtosUnicos[index];
                final controller = _quantidadeControllers[produto]!;

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
                              Text(produto.nome,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(produto.detalhes, style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 8),
                              Text("R\$ ${produto.preco}",
                                  style: const TextStyle(fontSize: 16, color: Colors.green)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text("Kg:"),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: 60,
                                    child: TextField(
                                      controller: controller,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      ),
                                      onChanged: (value) => setState(() {}),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        widget.produtos.removeWhere((p) => p == produto);
                                        _quantidadeControllers.remove(produto);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                        builder: (context) => PaymentPage(produtos: widget.produtos),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LifeGardenColors.primary,
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
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: LifeGardenColors.primary,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Carrinho',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        ],
      ),
    );
  }
}