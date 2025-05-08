import 'package:flutter/material.dart';
import 'constants/colors.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final produtos = [
      {'nome': 'Alface', 'imagem': 'assets/imagens/alface.png'},
      {'nome': 'Cenoura', 'imagem': 'assets/imagens/cenoura.jpg'},
      {'nome': 'Tomate', 'imagem': 'assets/imagens/tomate.jpg'},
      {'nome': 'Brócolis', 'imagem': 'assets/imagens/brocolis.jpg'},
      {'nome': 'Batata', 'imagem': 'assets/imagens/batata.jpg'},
      {'nome': 'Abóbora', 'imagem': 'assets/imagens/abobora.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Produtos'),
        backgroundColor: LifeGardenColors.primary,
      ),
      backgroundColor: LifeGardenColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: produtos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final produto = produtos[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      produto['imagem']!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    produto['nome']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: LifeGardenColors.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Fresco e natural",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LifeGardenColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Comprar"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
