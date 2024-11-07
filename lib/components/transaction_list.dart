import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, //O Container com tamanho pré definido para ListView
      //Operação ternária para lista vazia
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(height: 20), //cria espaço entre os elementos
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20), //cria espaço entre os elementos
                Container(
                  height: 200,
                  //Imagem de lista vazia
                  child: Image.asset(
                    'assets/images/waiting.png',
                    //ajuste de imagem no 'height' do Container
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              //o proposito do 'builder' é renderizar quando houver necessidade de mostrar na tela.
              //itemCount percorre a quantidade de itens na lista
              itemCount: transactions.length,
              //itemBuilder vai construir conforme a necessidade
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    //Alternativa ao 'Card'
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      //O valor fica num formato de Circulo
                      radius: 30,
                      child: Padding(
                        // Para o texto não ficar muito próximo da borda
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          //Widget para ajustar melhor o texto
                          child: Text(
                            'R\$${tr.value}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                  ),
                );
              },
              //Aqui será feito um map da lista de transações, e depois será convertido em elementos visuais
              //E também o formulário de inserir nova transação
            ),
    );
  }
}
