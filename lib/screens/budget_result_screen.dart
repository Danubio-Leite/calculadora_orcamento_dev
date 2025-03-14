import 'package:flutter/material.dart';
import '../models/budget.dart';

class BudgetResultScreen extends StatelessWidget {
  final Budget budget;

  const BudgetResultScreen({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamento Detalhado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  'Projeto: ${budget.nomeProjeto}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Descrição: ${budget.descricao}'),
                const SizedBox(height: 10),
                Text(
                    'Preço por hora: R\$ ${budget.precoHora.toStringAsFixed(2)}'),
                const SizedBox(height: 10),
                Text('Horas básicas: ${budget.baseHoras.toStringAsFixed(2)}'),
                const SizedBox(height: 10),
                Text(
                    'Horas extras para telas (${budget.numTelas} x 2): ${budget.extraTelas.toStringAsFixed(2)}'),
                if (budget.usaBaas)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                        'Horas extras para BaaS: ${budget.extraBaas.toStringAsFixed(2)}'),
                  ),
                if (budget.temLogin)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                        'Horas extras para Login: ${budget.extraLogin.toStringAsFixed(2)}'),
                  ),
                const Divider(height: 30, thickness: 1),
                Text(
                    'Total de horas estimadas: ${budget.totalHoras.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                Text(
                    'Orçamento total: R\$ ${budget.orcamentoTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
