import 'package:flutter/material.dart';
import '../components/appbar.dart';
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

  Future<void> _deleteBudget(int id) async {
    await BudgetDatabase.instance.deleteBudget(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Orçamento excluído com sucesso!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            // Implemente aqui a ação de desfazer, se necessário
          },
        ),
      ),
    );
    _loadBudgets();
  }

  Widget _buildDismissibleBackground({required Alignment alignment}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: Colors.red,
          alignment: alignment,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBudgetItem(Budget budget) {
    return Dismissible(
      key: Key(budget.id.toString()),
      background: _buildDismissibleBackground(alignment: Alignment.centerLeft),
      direction: DismissDirection.endToStart,
      secondaryBackground:
          _buildDismissibleBackground(alignment: Alignment.centerRight),
      onDismissed: (_) => _deleteBudget(budget.id!),
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            budget.nomeProjeto,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Total: R\$ ${budget.orcamentoTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BudgetDetailScreen(budget: budget),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBudgetList(List<Budget> budgets) {
    return RefreshIndicator(
      onRefresh: () async {
        _loadBudgets();
        await _budgetsFuture;
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10.0),
        itemCount: budgets.length,
        itemBuilder: (context, index) {
          return _buildBudgetItem(budgets[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Orçamentos Salvos'),
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
            return _buildBudgetList(snapshot.data!);
          }
        },
      ),
    );
  }
}
