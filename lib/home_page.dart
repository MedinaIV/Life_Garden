import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'model/produto.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Produto> carrinho = [];

  void adicionarProdutoAoCarrinho(Produto produto) {
    setState(() {
      carrinho.add(produto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/imagens/logo.png.png', height: 40),
        backgroundColor: LifeGardenColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaginaCarrinho(produtos: carrinho),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: PageView(
                children: [
                  Image.asset('assets/imagens/verduras.jpg', fit: BoxFit.cover),
                  Image.asset('assets/imagens/legumes.jpg', fit: BoxFit.cover),
                  Image.asset('assets/imagens/frescos.jpg', fit: BoxFit.cover),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Bem-vindo ao Life Garden!\nCompre verduras e legumes frescos direto do produtor.",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: LifeGardenColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Produtos em Destaque",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: LifeGardenColors.primary,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text("Ver Todos")),
                ],
              ),
            ),
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProductCard(
                    context,
                    'Alface',
                    'assets/imagens/alface.png',
                    '3,50',
                  ),
                  _buildProductCard(
                    context,
                    'Cenoura',
                    'assets/imagens/cenoura.jpg',
                    '4,20',
                  ),
                  _buildProductCard(
                    context,
                    'Tomate',
                    'assets/imagens/tomate.jpg',
                    '5,00',
                  ),
                  _buildProductCard(
                    context,
                    'Batata',
                    'assets/imagens/batata.jpg',
                    '3,80',
                  ),
                  _buildProductCard(
                    context,
                    'Brócolis',
                    'assets/imagens/brocolis.jpg',
                    '6,30',
                  ),
                  _buildProductCard(
                    context,
                    'Abóbora',
                    'assets/imagens/abobora.jpg',
                    '4,90',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String name,
    String imagePath,
    String price,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              "R\$ $price",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Produto produto = Produto(
                  name,
                  "Descrição do produto",
                  price,
                  imagePath,
                );
                adicionarProdutoAoCarrinho(produto);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$name adicionado ao carrinho!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LifeGardenColors.primary,
                minimumSize: const Size(double.infinity, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  }
}