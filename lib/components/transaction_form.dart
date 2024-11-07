import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

//Essa classe do Estado é privada
class _TransactionFormState extends State<TransactionForm> {
  //Aqui estamos utilizando um controller para tornar possivel o uso de variáveis no Stateful
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();
  DateTime? _selectedDate; // pegar o valor que foi
  //selecionado pelo usuário dentro do selectedDate

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    //Condicional para sair da funcao caso seja inserido um valor inválido
    if (title.isEmpty || value <= 0) {
      return;
    }

    //widget é uma variável para acessar todos os parâmetros da classe Stateful "TransactionForm"
    //Esse atributo 'widget' aponta para uma instancia da classe 'TransactionForm' (Assim a parte do bild "TransactionForm" foi transferida para o estado). Ou seja, o 'widget' permite a comunicação entre as classes (classe TransactionForm <=> classe State) através de um componente Statefull.
    widget.onSubmit(title, value);
  }

  //Mostrar um calendário
  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019), // data mais antiga que pode selecionar
      lastDate: DateTime.now(), // data finalS
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      _selectedDate = pickedDate;
    });

    print('Executado!!!');
  }

  @override
  Widget build(BuildContext context) {
    return
        //Aqui se encontra o formulário para inserir uma nova transação
        Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              //Esse controler está inserindo o valor do formulario na variavel de titulo
              controller: _titleController,
              onSubmitted: (_) =>
                  _submitForm(), ////Esse '_' serve somente para informar visualmente q mesmo precisando informar o parâmetro, eu não vou utilizar. onSubmitted = função para o 'enter' do teclado
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              //Esse controler está inserindo o valor do formulario na variavel de valor
              controller: _valueController,
              //aqui temos o comando para utilizar o teclado do tipo numerico para inserir o valor.
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              //container adicionado para acrescentar espaço para Row
              height: 70,
              child: Row(
                children: [
                  Text(
                    'Nenhuma data selecionada!',
                    style: Theme.of(context).textTheme.titleSmall,
                    // style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(foregroundColor: Colors.purple),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  //Botao de inserir nova transação no formulário
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
