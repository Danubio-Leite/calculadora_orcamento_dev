import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/button.dart';
import 'budget_form_screen.dart';
import 'saved_budgets_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Calculadora de Orçamentos',
        hasBackButton: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(
                onPressed: () {
                  // Navega para o formulário de novo orçamento
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BudgetFormScreen()),
                  );
                },
                text: 'Novo Orçamento',
              ),
              const SizedBox(height: 20),
              GradientButton(
                onPressed: () {
                  // Navega para a tela de orçamentos salvos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SavedBudgetsScreen()),
                  );
                },
                text: 'Orçamentos Salvos',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
