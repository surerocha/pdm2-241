import 'dart:convert';
import 'dart:io';

class Dependente {
  late String _nome;

  Dependente(this._nome);

  Map<String, dynamic> toJson() => {
        'nome': _nome,
      };
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(this._nome, this._dependentes);

  Map<String, dynamic> toJson() => {
        'nome': _nome,
        'dependentes': _dependentes.map((dependente) => dependente.toJson()).toList(),
      };
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(this._nomeProjeto, this._funcionarios);

  Map<String, dynamic> toJson() => {
        'nomeProjeto': _nomeProjeto,
        'funcionarios': _funcionarios.map((funcionario) => funcionario.toJson()).toList(),
      };
}

void main() {

  // 1. Criar vários objetos Dependentes
  var dependente1 = Dependente("Rodrigo Rochette");
  var dependente2 = Dependente("Priscila Vulcano Livia");
  var dependente3 = Dependente("Estefania Castelino");
  var dependente4 = Dependente("Leonardo Santiago");

  // 2. Criar vários objetos Funcionario
  var funcionario2 = Funcionario("Livia Vulcano", [dependente2]);
  var funcionario3 = Funcionario("Cristiana Castelino", [dependente3]);
  var funcionario4 = Funcionario("Maria Carmen Santiago", [dependente4]);

  // 3. Criar uma lista de Funcionarios
  var funcionariosList = [funcionario2, funcionario3, funcionario4];

  // 4. Criar um objeto Equipe Projeto
  var equipeProjeto1 = EquipeProjeto("Projeto 1", funcionariosList);

  // 6. Printar no formato JSON o objeto Equipe Projeto.

  var equipeProjetoJson = jsonEncode(equipeProjeto1);

  File('equipe_projeto.json').writeAsStringSync(equipeProjetoJson);

  print('Arquivo JSON gerado com sucesso! Acesse em equipe_projeto.json');

}

/*DEBUG CONSOLE -> Connecting to VM Service at ws://127.0.0.1:49648/c0WkbkW0URU=/ws
Arquivo JSON gerado com sucesso! Acesse em equipe_projeto.json

Exited.8

Arquivo JSON -> {"nomeProjeto":"Projeto 1","funcionarios":[{"nome":"Livia Vulcano","dependentes":[{"nome":"Priscila Vulcano Livia"}]},{"nome":"Cristiana Castelino","dependentes":[{"nome":"Estefania Castelino"}]},{"nome":"Maria Carmen Santiago","dependentes":[{"nome":"Leonardo Santiago"}]}]}
*/
