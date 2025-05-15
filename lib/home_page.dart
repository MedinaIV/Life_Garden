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
  int _selectedIndex = 0;

  void adicionarProdutoAoCarrinho(Produto produto) {
    setState(() {
      carrinho.add(produto);
    });
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PaginaCarrinho(produtos: carrinho),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
      );
    }
  }

  final TextEditingController _searchController = TextEditingController();
  String filtroCategoria = 'Todos';

  final List<Map<String, dynamic>> _produtos = [
    {
      'nome': 'Alface',
      'imagem': 'assets/imagens/alface.png',
      'preco': '3,50',
      'categoria': 'Verdura',
      'destaque': true,
    },
    {
      'nome': 'Cenoura',
      'imagem': 'assets/imagens/cenoura.jpg',
      'preco': '4,20',
      'categoria': 'Legumes',
      'destaque': true,
    },
    {
      'nome': 'Tomate',
      'imagem': 'assets/imagens/tomate.jpg',
      'preco': '5,00',
      'categoria': 'Legumes',
      'destaque': false,
    },
    {
      'nome': 'Batata',
      'imagem': 'assets/imagens/batata.jpg',
      'preco': '3,80',
      'categoria': 'Legumes',
      'destaque': true,
    },
    {
      'nome': 'Brócolis',
      'imagem': 'assets/imagens/brocolis.jpg',
      'preco': '6,30',
      'categoria': 'Verdura',
      'destaque': false,
    },
    {
      'nome': 'Abóbora',
      'imagem': 'assets/imagens/abobora.jpg',
      'preco': '4,90',
      'categoria': 'Legumes',
      'destaque': true,
    },
  ];

  List<Map<String, dynamic>> get _produtosFiltrados {
    return _produtos.where((produto) {
      final busca = _searchController.text.toLowerCase();
      final nome = produto['nome'].toLowerCase();
      final categoria = produto['categoria'];

      if (filtroCategoria == 'Todos' ||
          (filtroCategoria == 'Destaques' && produto['destaque']) ||
          filtroCategoria == categoria) {
        return nome.contains(busca);
      }
      return false;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/imagens/logo.png.png', height: 40),
        backgroundColor: LifeGardenColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Buscar produto...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _filtroBotao('Todos'),
                    _filtroBotao('Destaques'),
                    _filtroBotao('Verdura'),
                    _filtroBotao('Legumes'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _produtosFiltrados.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final produto = _produtosFiltrados[index];
                  return _buildProductCard(
                    context,
                    produto['nome'],
                    produto['imagem'],
                    produto['preco'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      child: Container(
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

  Widget _filtroBotao(String label) {
    final bool selecionado = filtroCategoria == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: selecionado,
        onSelected: (_) => setState(() {
          filtroCategoria = label;
        }),
        selectedColor: LifeGardenColors.primary,
      ),
    );
  }
}