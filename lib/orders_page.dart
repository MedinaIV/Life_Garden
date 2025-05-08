import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: RastreamentoPedidoPage()));

class RastreamentoPedidoPage extends StatelessWidget {
  final int statusIndex = 2; // 0 = Realizado, 1 = Pagamento, 2 = Enviado, 3 = Entregue

  final List<EtapaPedido> etapas = [
    EtapaPedido("Pedido Realizado", Icons.shopping_basket),
    EtapaPedido("Pagamento Confirmado", Icons.attach_money),
    EtapaPedido("Pedido Enviado", Icons.local_shipping),
    EtapaPedido("Pedido Entregue", Icons.check_box),
  ];

  @override
  Widget build(BuildContext context) {
    double progresso = (statusIndex + 1) / etapas.length;

    return Scaffold(
      appBar: AppBar(title: Text("Rastreamento de Pedido")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Column(
              children: [
                LinearProgressIndicator(
                  value: progresso,
                  color: Colors.blue,
                  backgroundColor: Colors.grey[300],
                  minHeight: 10,
                ),
                SizedBox(height: 16),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: etapas.asMap().entries.map((entry) {
                int idx = entry.key;
                EtapaPedido etapa = entry.value;
                bool concluido = idx <= statusIndex;

                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: concluido ? Colors.blue : Colors.grey,
                      child: Icon(etapa.icone, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      etapa.titulo,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 32),

            ElevatedButton(
              onPressed: () {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Acompanhando o seu pedido...")),
                );
              },
              child: Text("Acompanhe seu pedido"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 16),

            Text.rich(
              TextSpan(
                text: "Seu pedido ",
                style: TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                      text: "#15556",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                  TextSpan(text: " foi entregue à transportadora"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EtapaPedido {
  final String titulo;
  final IconData icone;

  EtapaPedido(this.titulo, this.icone);
}