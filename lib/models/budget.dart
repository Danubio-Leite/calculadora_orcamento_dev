class Budget {
  int? id;
  String nomeProjeto;
  String descricao;
  double precoHora;
  double baseHoras;
  int numTelas;
  bool usaBaas;
  bool temLogin;

  // Constantes para horas extras
  static const double horasPorTela = 2.0;
  static const double horasBaas = 4.0;
  static const double horasLogin = 3.0;

  Budget({
    this.id,
    required this.nomeProjeto,
    required this.descricao,
    required this.precoHora,
    required this.baseHoras,
    required this.numTelas,
    required this.usaBaas,
    required this.temLogin,
  });

  double get extraTelas => numTelas * horasPorTela;
  double get extraBaas => usaBaas ? horasBaas : 0;
  double get extraLogin => temLogin ? horasLogin : 0;

  double get totalHoras => baseHoras + extraTelas + extraBaas + extraLogin;
  double get orcamentoTotal => totalHoras * precoHora;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeProjeto': nomeProjeto,
      'descricao': descricao,
      'precoHora': precoHora,
      'baseHoras': baseHoras,
      'numTelas': numTelas,
      'usaBaas': usaBaas ? 1 : 0,
      'temLogin': temLogin ? 1 : 0,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      nomeProjeto: map['nomeProjeto'],
      descricao: map['descricao'],
      precoHora: map['precoHora'],
      baseHoras: map['baseHoras'],
      numTelas: map['numTelas'],
      usaBaas: map['usaBaas'] == 1,
      temLogin: map['temLogin'] == 1,
    );
  }
}
