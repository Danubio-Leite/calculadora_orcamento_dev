import 'package:flutter/material.dart';
import '../models/budget.dart';
import 'budget_result_screen.dart';

class BudgetFormScreen extends StatefulWidget {
  const BudgetFormScreen({super.key});

  @override
  State<BudgetFormScreen> createState() => _BudgetFormScreenState();
}

class _BudgetFormScreenState extends State<BudgetFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeProjetoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoHoraController = TextEditingController();
  final TextEditingController _baseHorasController = TextEditingController();
  final TextEditingController _numTelasController = TextEditingController();

  bool _usaBaas = false;
  bool _temLogin = false;

  @override
  void dispose() {
    _nomeProjetoController.dispose();
    _descricaoController.dispose();
    _precoHoraController.dispose();
    _baseHorasController.dispose();
    _numTelasController.dispose();
    super.dispose();
  }

  void _calcularOrcamento() {
    if (_formKey.currentState!.validate()) {
      String nomeProjeto = _nomeProjetoController.text;
      String descricao = _descricaoController.text;
      double precoHora = double.parse(_precoHoraController.text);
      double baseHoras = double.parse(_baseHorasController.text);
      int numTelas = int.parse(_numTelasController.text);

      Budget budget = Budget(
        nomeProjeto: nomeProjeto,
        descricao: descricao,
        precoHora: precoHora,
        baseHoras: baseHoras,
        numTelas: numTelas,
        usaBaas: _usaBaas,
        temLogin: _temLogin,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BudgetResultScreen(budget: budget),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Orçamento'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Dados do Projeto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nomeProjetoController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Projeto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do projeto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Dados do Desenvolvedor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _precoHoraController,
                decoration: const InputDecoration(
                  labelText: 'Preço por hora (R\$)',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço por hora';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Insira um valor numérico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _baseHorasController,
                decoration: const InputDecoration(
                  labelText: 'Horas básicas estimadas',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a estimativa de horas';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Insira um valor numérico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _numTelasController,
                decoration: const InputDecoration(
                  labelText: 'Número de telas do aplicativo',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de telas';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Insira um número inteiro válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Funcionalidades Adicionais',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Usar BaaS (Banco de Dados as a Service)'),
                value: _usaBaas,
                onChanged: (bool value) {
                  setState(() {
                    _usaBaas = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Incluir funcionalidade de Login'),
                value: _temLogin,
                onChanged: (bool value) {
                  setState(() {
                    _temLogin = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularOrcamento,
                child: const Text('Calcular Orçamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
