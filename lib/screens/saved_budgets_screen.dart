import 'package:flutter/material.dart';
import '../database/budget_database.dart';
import '../models/budget.dart';
import 'budget_detail_screen.dart';

class SavedBudgetsScreen extends StatefulWidget {
  const SavedBudgetsScreen({super.key});

  @override
  State<SavedBudgetsScreen> createState() => _SavedBudgetsScreenState();
}

class _SavedBudgetsScreenState extends State<SavedBudgetsScreen> {
  late Future<List<Budget>> _budgetsFuture;

  @override
  void initState() {
    super.initState();
    _loadBudgets();
  }

  void _loadBudgets() {
    setState(() {
      _budgetsFuture = BudgetDatabase.instance.getBudgets();
    });
  }

  void _deleteBudget(int id) async {
    await BudgetDatabase.instance.deleteBudget(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Orçamento excluído com sucesso!')),
    );
    _loadBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamentos Salvos'),
      ),
      body: FutureBuilder<List<Budget>>(
        future: _budgetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum orçamento salvo.'));
          } else {
            final budgets = snapshot.data!;
            return ListView.builder(
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                final budget = budgets[index];
                return Dismissible(
                  key: Key(budget.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteBudget(budget.id!);
                  },
                  child: ListTile(
                    title: Text(budget.nomeProjeto),
                    subtitle: Text(
                        'Total: R\$ ${budget.orcamentoTotal.toStringAsFixed(2)}'),
                    onTap: () {
                      // Navega para a tela de visualização do orçamento salvo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BudgetDetailScreen(budget: budget),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
