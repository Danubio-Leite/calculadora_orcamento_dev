import 'package:flutter/material.dart';
import 'budget_form_screen.dart';
import 'saved_budgets_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Orçamento'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navega para o formulário de novo orçamento
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BudgetFormScreen()),
                  );
                },
                child: const Text('Novo Orçamento'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navega para a tela de orçamentos salvos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SavedBudgetsScreen()),
                  );
                },
                child: const Text('Orçamentos Salvos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
