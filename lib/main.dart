import 'package:flutter/material.dart';
import 'dart:math';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      home: MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        // Cor do botão
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
        ),

        //Estilo das fontes
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontFamily: 'OpenSans',
            color: Colors.black,
          ),
        ),

        // Estilo do barra superior do Aplicativo
        appBarTheme: AppBarTheme(
          color: Colors.purple,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//MyHomePage representa a página principal do aplicativo
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Aqui temos o layout base do aplicativo

  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta Antiga',
      value: 400.00,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Cartão de Crédito',
      value: 1021.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Lanche',
      value: 11.30,
      date: DateTime.now(),
    ),
  ];

  // 'where' é um método tipo filter. O parâmetro será uma função 'callback' que retornará uma lista das transações dos ultimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      // 'isAfter' significa 'depois de'. Então na lógica, se a data for depois do '7 dias atrás' ex: 6 dias, 5 dias atrás, etc..., então irá retornar true.
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  //Função para adicionar uma transação
  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(), //gerar valor aleatório
      title: title,
      value: value,
      date: DateTime.now(), //data de agora
    );

    //adicionando a nova transação na lista
    setState(() {
      _transactions.add(newTransaction);
    });

    //Metodo para fechar o Modal.
    Navigator.of(context).pop();
  }

  //Metodo que abre o 'Modal' para inserir as transações
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
            _addTransaction); //o parametro é uma funçao 'submit'
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas Pessoais',
        ),
        //Estrutura para adicionar um botão com função
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.add), //add = icone de adicionar
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),
      //SingleChildScrollView serve para permitir que o conteúdo 'role' pela tela do celular sem problemas de 'overview'. Se for em outro local, precisa certificar se o componente Pai possui o tamanho pré-definido.
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Componente para mostrar o Grafico
            Chart(_recentTransactions),
            //Comunicação direta: quando o componente 'pai' passa dados para o componente 'filho' renderizar.
            TransactionList(_transactions),
          ],
        ),
      ),
      //Botão flutuante de adicionar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // Formato do botão
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () => _openTransactionFormModal(context),
      ),
      //Centralizar o botão
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
