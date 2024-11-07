import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  //lista de transacoes recentes
  final List<Transaction> recentTransaction;

  // construtor
  Chart(this.recentTransaction);

  //Temos que identificar qual dia da semana caiu cara transação e agrupa-los

  List<Map<String, Object>> get groupedTransactions {
    //o generate vai gerar uma lista com caracteristicas especificas
    //'7' é a quantidade de elentos da lista
    //o outro parametro é uma função com 'index'
    return List.generate(7, (index) {
      //nessa função, ele vai pegar o dia de hoje e subtrair o numero de dias no 'index'. Se hoje for quinta e o index for 3, ele vai pegar segunda feira, se o index for 0 ele retorna hoje(quinta-feira). Ele vai percorrer todos os dias da semana.

      //variável que pega o dia de hoje e subtrai pelo indice (que representa os dias anteriores)
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      //Vamos pegar agora a soma de todos os valores incluídos no mesmo dia da semana.
      double totalSum = 0.0;

      //O 'for' vai percorrer a transação e descobrir se ela tem o mesmo dia, mes e ano do weekDay. Note que toda essa analise só irá considerar os dias da mesma semana da transação (weekDay).
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        //'DateFormat.E' é a sigla do dia da semana
        //Agora ele vai pegar o dia em weekDay e formatar para a primeira letra do dia da semana.
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList(); //reverter a lista dos dias,
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    }); //metodo tipo 'reduce' que serve para acumular dados. 'sum' é o acumulador e o 'tr' é o map que está sendo retornado no 'groupedTransactions'. O objetivo aqui é somar todas as transações da semana
    // O parâmetro '0.0' do fold indica o valor inicial do acumulador
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin:
          EdgeInsets.all(20), //para os elementos ficarem distantes da margem
      child: Padding(
        //O padding deixa um espaço invisível na periferia do gráfico
        padding: const EdgeInsets.all(10),
        child: Row(
            //Aqui será mostrado o conteúdo do gráfico. Que é um map que percorre os dias da semana e seu respectivo valor.
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, //alinhamento dos itens por toda a 'Row'

            children: groupedTransactions.map((tr) {
              return Flexible(
                fit: FlexFit.tight,
                //garantir o espaçamento igual entre os itens do gráfico mesmo com valores que ultrapassam o comum
                child: ChartBar(
                  label: tr['day'] as String,
                  value: tr['value'] as double,
                  percentage: (tr['value'] as double) / _weekTotalValue,
                ),
              );
            }).toList()),
      ),
    );
  }
}
