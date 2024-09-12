import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  String? _data;
  String? _email;
  String? _cpf;
  String? _valor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário com Validação - Anderson Maia e Sure Rocha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Data (dd-mm-aaaa)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe uma data';
                  }
                  if (!isValidDate(value)) {
                    return 'Data inválida. Exemplo válido: 31-12-2023';
                  }
                  return null;
                },
                onSaved: (value) => _data = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um email';
                  }
                  if (!isValidEmail(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CPF (apenas números)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um CPF';
                  }
                  if (!isValidCPF(value)) {
                    return 'CPF inválido';
                  }
                  return null;
                },
                onSaved: (value) => _cpf = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Valor (digite um valor numérico)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um valor';
                  }
                  if (!isValidValor(value)) {
                    return 'Valor inválido. Exemplo válido: 1234.56';
                  }
                  return null;
                },
                onSaved: (value) => _valor = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Aqui você pode fazer algo com os valores válidos
                    print('Formulário válido!');
                    print('Data: ${_data ?? ''}');
                    print('Email: ${_email ?? ''}');
                    print('CPF: ${_cpf ?? ''}');
                    print('Valor: ${_valor ?? ''}');
                  } else {
                    print('Formulário inválido!');
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidDate(String value) {
    RegExp dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
    if (!dateRegex.hasMatch(value)) {
      return false;
    }
    List<int> dateParts = value.split('-').map(int.parse).toList();
    try {
      DateTime date = DateTime(dateParts[2], dateParts[1], dateParts[0]);
      return date.day == dateParts[0] &&
             date.month == dateParts[1] &&
             date.year == dateParts[2];
    } catch (e) {
      return false;
    }
  }

  bool isValidEmail(String value) {
    RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value);
  }

  bool isValidCPF(String value) {
    // Remove caracteres não numéricos
    final cpf = value.replaceAll(RegExp(r'\D'), '');
    if (cpf.length != 11 || cpf.split('').every((char) => char == cpf[0])) {
      return false; // Verifica se todos os dígitos são iguais
    }

    // Validação do CPF
    int sum(int a, int b, int c, int d, int e, int f, int g, int h, int i) {
      return a * 10 + b * 9 + c * 8 + d * 7 + e * 6 + f * 5 + g * 4 + h * 3 + i * 2;
    }

    int calculateDigit(String cpf, int start) {
      int total = sum(
        int.parse(cpf[0 + start]),
        int.parse(cpf[1 + start]),
        int.parse(cpf[2 + start]),
        int.parse(cpf[3 + start]),
        int.parse(cpf[4 + start]),
        int.parse(cpf[5 + start]),
        int.parse(cpf[6 + start]),
        int.parse(cpf[7 + start]),
        int.parse(cpf[8 + start]),
      );
      int remainder = total % 11;
      return remainder < 2 ? 0 : 11 - remainder;
    }

    int firstDigit = calculateDigit(cpf, 0);
    int secondDigit = calculateDigit(cpf, 1);

    return firstDigit == int.parse(cpf[9]) && secondDigit == int.parse(cpf[10]);
  }

  bool isValidValor(String value) {
    // Verifica se o valor é um número válido
    double? parsedValue = double.tryParse(value.replaceAll(',', '.'));
    if (parsedValue == null) {
      return false;
    }
    // Opcional: Verifica se o valor é positivo (se necessário)
    return parsedValue >= 0;
  }
}

void main() {
  runApp(MaterialApp(
    home: MyForm(),
  ));
}
